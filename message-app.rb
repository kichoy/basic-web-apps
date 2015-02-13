require "sinatra"     # Load the Sinatra web framework

get("/") do
  html = ""

  html.concat("<h1>Message of The Day</h1>")
  html.concat("<a href='/message'><p>See today's message.</p></a>")

  # dumb style
  html.concat('<style>
    body {
        background-color: ##E6B8B8;
    }
    
    h1 {
        color: orange;
        text-align: center;
    }
    
    p {
        font-family: "Times New Roman";
        font-size: 20px;
        text-align: center;
    }
  </style>')
  
  body(html)
end

get("/message") do
  file_contents = File.read("message-of-the-day.txt")

  html = ""
  html.concat("<h1>Message of the Day</h1>")
  html.concat("<p>Today's message is: #{file_contents}")

  # dumb style
  html.concat('<style>
      body {
          background-color: ##E6B8B8;
      }
      
      h1 {
          color: orange;
          text-align: center;
      }
      
      p {
          font-family: "Times New Roman";
          font-size: 20px;
          text-align: center;
      }
    </style>')

  body(html)
end
