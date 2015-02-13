require "sinatra"     # Load the Sinatra web framework

get("/") do
  html = ""

  html.concat("<h1>Hello, fsfsf!</h1>")
  html.concat("<ul>")
  html.concat('<style> body {background-color: #33CC66;} </style>')
  html.concat("<li><a href='/waffles'>show me waffles</a></li>")
  html.concat("<li><a href='/pancakes'>show me pancakes</a></li>") # pancakes page
  html.concat("<li><a href='/santa'>show me santa</a></li>")
  html.concat("<li><a href='/waffles/chocolate'>show me chocolate</a></li>")
  html.concat("<li><a href='/bake?baked_good=cookies&count=10'>bake 10 cookies</a></li>")
  html.concat("\n<li><a href='/bake?baked_good=cronut&count=6' onmouseover='alert(10)'> bake 6 cronuts</a></li>") # has mouse over alert
  html.concat("<li><a href='/bake?baked_good=cupcakes&count=1138'>bake 1138 cupcakes</a></li>")
  html.concat("\n<li><a href='/bake?baked_good=santas&count=1'>bake over 900 santas</a></li>")
  html.concat("<li><a href='/eat?animal=santas&count=3'>eat 3 santas</a></li>")
  html.concat("</ul>")
  
  html.concat('<style>
    body {
        background-color: #d0e4fe;
    }
    
    h1, li {
        color: orange;
        text-align: center;
    }
  </style>')

  body(html)
end

get("/waffles") do
  html = ""

  html.concat("<h1>Waffles are delicious.</h1>")

  body(html)
end

get("/santa") do
  html = ""
  
  html.concat('<h1 style="color:red; text-align: center"> Santa is delicious.</h1>')
  html.concat('<img src="http://www.turnbacktogod.com/wp-content/uploads/2008/12/santa-claus-pics-0101.jpg" alt="santa is delicious" text-align:"center">')
  html.concat('<style> body {background-color: #33CC66;}')

  body(html)
end


get("/waffles/chocolate") do
  html = ""

  html.concat("<h1>Chocolate waffles: more delicious.</h1>")
  html.concat("<p>Don't believe me?!</p>")

  body(html)
end

# Visit, e.g., /bake?baked_good=waffles&count=20
get("/bake") do
  count = Integer(params["count"])
  baked_good = String(params["baked_good"])

  html = "I'm going to bake #{count} #{baked_good}!"

  html.concat("<ul>")
  count.times do |num|
    html.concat("<li>#{baked_good} number #{num}</li>")
  end
  html.concat("</ul>")

  body(html)
end

# Visit, e.g., /eat?animal=waffles&count=20
get("/eat") do
  count = Integer(params["count"])
  animal = String(params["animal"])

  html = "I'm going to eat #{count} #{animal}!"

  html.concat("<ul>")
  count.times do |num|
    html.concat("<li>#{animal} number #{num}</li>")
  end
  html.concat("</ul>")

  body(html)
end
