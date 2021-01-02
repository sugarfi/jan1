require "kemal"
require "celestine"

WIDTH = 800
HEIGHT = 600

START_SIZE = 100
START_X = WIDTH  / 2 - START_SIZE / 2
START_Y = HEIGHT / 2 - START_SIZE / 2

COLORS = [
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "indigo",
    "violet"
]

EDGES = [
    {-1, 0},
    {-1, 1},
    {2,  0},
    {2,  1},
    {0, -1},
    {1, -1},
    {0,  2},
    {1,  2}
]

macro nest_loop(count, max)
    {% if count != max %}
        EDGES.each do |edge|
            n = {{count + 1}}
            size = START_SIZE / {{2 ** (count + 1)}}
            x, y = edge
            x *= size
            y *= size

            r{{count}} = Celestine::Rectangle.new
            {% if max > COLORS.size %}
                r{{count}}.stroke = COLORS[n % COLORS.size]
            {% else %}
                r{{count}}.stroke = COLORS[n]
            {% end %}
            r{{count}}.stroke_width = 2
            r{{count}}.x = old_x{{count}} = old_x{{count - 1}} + x
            r{{count}}.y = old_y{{count}} = old_y{{count - 1}} + y
            r{{count}}.width = r{{count}}.height = size
        
            nest_loop {{count + 1}}, {{max}}
            ctx << r{{count}}
        end
    {% end %}
end

get "/" do
    %(
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>Genuary 1</title>
        </head>
        <body>
            <ul>
                <li><a href="/max3">max=3</a></li>
                <li><a href="/max4">max=4</a></li>
            <b>Warning: the following values for max may slow down your computer - view at your own risk</b>
                <li><a href="/max5">max=5</a></li>
                <li><a href="/max6">max=6</a></li>
            </ul>     
        </body>
    </html>
    )
end

get "/max3" do
    Celestine.draw do |ctx|
        ctx.width = WIDTH
        ctx.height = HEIGHT
        ctx.width_units = ctx.height_units = "px"

        n = 0
        size = START_SIZE

        r = Celestine::Rectangle.new
        r.stroke = COLORS[n % COLORS.size]
        r.stroke_width = 2
        r.x = old_x = START_X
        r.y = old_y = START_Y
        r.width = r.height = size

        nest_loop 0, 3

        ctx << r
    end
end

get "/max4" do
    Celestine.draw do |ctx|
        ctx.width = WIDTH
        ctx.height = HEIGHT
        ctx.width_units = ctx.height_units = "px"

        n = 0
        size = START_SIZE

        r = Celestine::Rectangle.new
        r.stroke = COLORS[n % COLORS.size]
        r.x = old_x = START_X
        r.y = old_y = START_Y
        r.width = r.height = size

        nest_loop 0, 4

        ctx << r
    end
end

get "/max5" do
    Celestine.draw do |ctx|
        ctx.width = WIDTH
        ctx.height = HEIGHT
        ctx.width_units = ctx.height_units = "px"

        n = 0
        size = START_SIZE

        r = Celestine::Rectangle.new
        r.stroke = COLORS[n % COLORS.size]
        r.x = old_x = START_X
        r.y = old_y = START_Y
        r.width = r.height = size

        nest_loop 0, 5

        ctx << r
    end
end

get "/max6" do
    Celestine.draw do |ctx|
        ctx.width = WIDTH
        ctx.height = HEIGHT
        ctx.width_units = ctx.height_units = "px"

        n = 0
        size = START_SIZE

        r = Celestine::Rectangle.new
        r.stroke = COLORS[n % COLORS.size]
        r.x = old_x = START_X
        r.y = old_y = START_Y
        r.width = r.height = size

        nest_loop 0, 6

        ctx << r
    end
end

Kemal.run
