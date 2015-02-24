require "sinatra"
require "data_mapper" 

require "./database_setup_letterGradeMan"

class Message
  include DataMapper::Resource

  property :id,         Serial
  property :body,       Text,     required: true
  property :created_at, DateTime, required: true
end

DataMapper.finalize()
DataMapper.auto_upgrade!()


get("/") do
  erb(:letterGradeMan)
end

post("/messages") do
  message_body = params["body"]
  message_time = DateTime.now

  message = Message.create(body: message_body, created_at: message_time)

  if message.saved?
    redirect("/")
  else
    erb(:error)
  end
end


def letter_grade (pct_grade)
  if pct_grade >= 90
    return "A"
  elsif pct_grade >= 80
    return "B"
  elsif pct_grade >= 70
    return "C"
  elsif pct_grade >= 60
    return "D"
  else
    return "F"
  end
end

# input2 = Integer(gets().chomp())
