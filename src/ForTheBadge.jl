module ForTheBadge

using Colors
using Luxor

rtext = "60% OF THE TIME"
ltext = "WORKS EVERY TIME"

rcolor = colorant"blue"
lcolor = colorant"red"

# Drawing(1000, 1000, :pdf, "lol.pdf")
@pdf begin

    origin(100, 100)

    fontsize(20)

    local lbb

    @layer begin

        rbb = BoundingBox(rtext) + 13 * 2

        sethue(colorant"green")

        poly(rbb, :fill, close=true)

        lbb = (BoundingBox(ltext) + 13 * 2) + (rbb.corner2.x + 13, 0)

        sethue(colorant"blue")

        poly(lbb, :fill, close=true)

    end

    sethue(colorant"white")

    fontface("Roboto Medium")

    text(rtext)

    fontface("Montserrat ExtraBold")

    text(ltext, Point(lbb.corner1.x + 13, 0); valign = :centre)

end

end # module


using Luxor
@pdf begin
    t = Tiler(200, 50, 1, 2, margin=0)
    fontsize(20)
    labels=["TEST IT", "SHIP IT"]
    for (k, p) in enumerate(t)
        randomhue()
        box(first(p), 100, 50, :fill)
        sethue("white")
        text(labels[k], first(p), halign=:center, valign=:middle)
    end
end 200 50 "/tmp/badge"

local xlength
using Pkg; Pkg.activate(".")
# @pdf begin
using Luxor, Colors
Drawing(800, 50)
fontsize(20)
labels=["BUILT WITH", "GRAV"]
fonts = ["Roboto Medium", "Montserrat ExtraBold"]
bgcolours = [colorant"orange", colorant"dark orange"]
textcolours = [colorant"white", colorant"white"]

rawextents = [begin fontface(fonts[i]); ceil(textextents(labels[i])[3]) + 26 end for i in eachindex(labels)]
finish()
pushfirst!(rawextents, 0.0)

extents = [sum(rawextents[1:i]) for i in eachindex(rawextents)]

xlength = sum(rawextents)


midpoints = ((rawextents[i]) / 2 + ((i == zero(typeof(i))) ? 0 : sum(rawextents[1:i-1])) for i in eachindex(extents)) |> collect

Drawing(xlength, 50, "label.svg")

for (k, p) in enumerate(midpoints[2:end])
    sethue(bgcolours[k])
    box(Point(extents[k], 0), Point(extents[k+1], 50), :fill)
    sethue(textcolours[k])
    fontface(fonts[k])
    fontsize(20)
    text(labels[k], Point(p, 25), halign=:center, valign=:middle)
end
finish()
preview()
# end xlength 50 "/tmp/badge"
