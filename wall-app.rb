require "sinatra"     # Load the Sinatra web framework
require "data_mapper" # Load the DataMapper database library

require "./database_setup"

class Message
  include DataMapper::Resource

  property :id,         Serial
  property :body,       Text,     required: true
  property :created_at, DateTime, required: true
  property :title,      String
  property :text_format,String  # bold or italics
end

DataMapper.finalize()
DataMapper.auto_upgrade!()

get("/") do
  records = Message.all(order: :created_at.desc)
  erb(:index, locals: { messages: records })
end

post("/messages") do
  message_body = params["body"]
  message_text_format = params["text-format"]
  message_title = params["title"]
  message_time = DateTime.now
  
  message = Message.create(body: message_body, created_at: message_time, title: message_title, text_format: message_text_format)

  if message.saved?
    redirect("/")
  else
    erb(:error)
  end
end

# delete message
post("/messages/*/destroy") do |message_id|
  message = Message.get(message_id)
  message.destroy
  
  if message.destroyed?
    redirect("/")
  else
    body("Something went terribly wrong!")
  end
end

# edit message
post("/messages/*/edit") do |message_id|
  message = Message.get(message_id)
  message_body = params["body"]
  message_text_format = params["text-format"]
  message_title = params["title"]
  
  message = Message.update(body: message_body, title: message_title, text_format: message_text_format)

  if message.saved?
    redirect("/")
  else
    body("Something went terribly wrong!")
  end
end

