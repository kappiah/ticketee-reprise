unless User.exists?(email: 'admin@example.com')
  User.create!(email: "admin@example.com", password: "password", admin: true)
end

unless User.exists?(email: 'viewer@example.com')
  User.create!(email: "viewer@example.com", password: "password")
end

["Sublime Text 3", "Internet Explorer"].each do |project|
  unless Project.exists?(name: project)
    Project.create!(name: project, description: "A sample project about #{project}")
  end
end

unless State.exists?
  State.create(name: "New", colour: "#0066CC")
  State.create(name: "Open", colour: "#008000")
  State.create(name: "Closed", colour: "#990000")
  State.create(name: "Awesome", colour: "#663399")
end
