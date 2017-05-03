require_relative '../models/robot.rb'

class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  attr_reader :robots, :robot

  get '/robots' do
    @robots = Robot.all
    erb :index
  end

  get '/robots/new' do
    erb :new_robot
  end

  post '/robots' do
    robot = Robot.new(params[:robot])
    robot.save
    redirect '/robots'
  end

  get '/robots/:id' do
    @robot = Robot.find(params[:id])
    erb :show
  end

  get '/robots/:id/edit' do
    @robot = Robot.find(params[:id])
    erb :edit_robot
  end

  put '/robots/:id' do |id|
    Robot.update(id.to_i, params[:robot])
    redirect '/robots/#{id}'
  end

  delete '/robots/:id' do
    Robot.delete(params[:id])
    redirect '/robots'
  end

  not_found do
    erb :error
  end

end
