require "sinatra"     # Load the Sinatra web framework
require "data_mapper" # Load the DataMapper database library

require "erb" # Used to escape html text 
include ERB::Util # Required for using the erb library

require "./database_setup"

helpers do
  def formatted_message_body(message)
    case message.text_format # line not necessary but nice
    when :bold # possible to use 'if'
      "<strong>#{h(message.body)}</strong>"
    when :italics
      "<i>#{h(message.body)}</i>"
    else
      h(message.body)
    end
  end
end

class Message
  include DataMapper::Resource

  property :id,         Serial
  property :body,       Text,     required: true
  property :created_at, DateTime, required: true
  property :likes,      Integer,  required: true, default: 0 
  property :location,   String
  property :title,      String
  property :text_format,Enum[:bold, :italics, :""]
  
end

DataMapper.finalize()
DataMapper.auto_upgrade!()

get("/") do
  records = Message.all(order: :created_at.desc) #default 
  erb(:index, locals: { messages: records })
end

post("/") do
  sort_by = params["sort-by"]
  if (sort_by == "newFirst")
    records = Message.all(order: :created_at.desc)
  elsif (sort_by == "oldFirst")
    records = Message.all(order: :created_at.asc)
  elsif (sort_by == "mostLikes")
    records = Message.all(order: :likes.desc)
  end
  erb(:index, locals: { messages: records })
end

post("/messages") do
  message_body = params["body"].strip #strip removes leading/trailing spaces
  message_location = params["location"].strip
  message_text_format = params["text-format"]
  message_title = params["title"].strip 
  message_time = DateTime.now
  
  message = Message.create(
    body:        message_body,
    location:    message_location,
    created_at:  message_time,
    title:       message_title,
    text_format: message_text_format
  )

  if message.saved?
    redirect("/")
  else
    erb(:error)
  end
end

# delete message
post("/messages/*/delete") do |message_id|
  message = Message.get(message_id)
  message.destroy
  
  if message.destroyed?
    redirect("/")
  else
    body("Something went terribly wrong!.")
  end
end

# like message
post("/messages/*/like") do |message_id|
  # # used once to give all the messages likes
  # messages = Message.all(order: :created_at.desc)
  # messages.each do |message|
  #   message = Message.update(location: "");
  # end
  
  message = Message.get(message_id)
  message.likes += 1
  message.save
  
  if message.saved?
    redirect("/")
  else
    body("Something went terribly wrong!")
  end 
end

# sort messages by - NOT BEING USED
post("/sort-by") do 
  sort_by = params["sort-by"].chomp
  if (sort_by == "newFirst")
    records = Message.all(order: :created_at.desc)
  elsif (sort_by == "oldFirst")
    records = Message.all(order: :created_at.asc)
  elsif (sort_by == "mostLikes")
    records = Message.all(order: :likes.desc)
  end
  erb(:index, locals: { messages: records })
end









# doesn't work
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

