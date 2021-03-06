class User
  attr_reader :id, :name, :email, :username

  def initialize(id, name, email, username)
    @id = id
    @name = name
    @email = email
    @username = username
  end

  def self.sign_up(name:, email:, username:, password:)
    connection.exec("INSERT INTO users (name, email, username, password) VALUES ('#{name}', '#{email}', '#{username}', '#{password}')")
    log_in(username: username, password: password)
  end

  def self.log_in(username:, password:)
    user_data = connection.exec("SELECT * FROM users WHERE username = '#{username}' AND password = '#{password}'").first

    raise 'Invalid credentials' if user_data.nil?

    User.create(user_data)
  end

  def self.find(id:)
    user_data = connection.exec("SELECT * FROM users WHERE id = #{id}").first

    return if user_data.nil?

    User.create(user_data)
  end

  private
  def self.create(user_data)
    User.new(user_data["id"].to_i, user_data["name"], user_data["email"], user_data["username"])
  end

  private
  def self.connection
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'chitter_test')
    else
      PG.connect(dbname: 'chitter')
    end
  end

end
