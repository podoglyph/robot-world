require 'sqlite3'

class Robot
  attr_reader :database, :id, :name, :city, :department, :state

  def initialize(robot_params)
    @id = robot_params["id"] if robot_params["id"]
    @name = robot_params["name"]
    @city = robot_params["city"]
    @state = robot_params["state"]
    @department = robot_params["department"]
    @database = SQLite3::Database.new('db/robot_world_development.db')
    @database.results_as_hash = true
  end

  def self.database
    database = SQLite3::Database.new("db/robot_world_development.db")
    database.results_as_hash = true
    database
  end

  def self.all
    robots = database.execute("SELECT * FROM robots;")

    robots.map do |r|
      Robot.new(r)
    end
  end

  def self.find(id)
    robot = database.execute("SELECT * FROM robots WHERE id=?", id).first
    Robot.new(robot)
  end

  def self.edit(id, robot_params)
    database.execute("UPDATE robots
                      SET name = ?,
                      city = ?,
                      state = ?,
                      department = ?
                      WHERE id=?;",
                      robot_params[:name],
                      robot_params[:city],
                      robot_params[:state],
                      robot_params[:department],
                      id)
  end


  def self.delete(id)
    database.execute("DELETE FROM robots
                      WHERE id=?;",
                      id)
  end

  def save
    @database.execute("INSERT INTO robots (name, city, state, department) VALUES (?,?,?,?);", @name, @city, @state, @department)
  end

end
