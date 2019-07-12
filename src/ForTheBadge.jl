module ForTheBadge

    using Colors
    using Luxor

    """
        badge(
            labels::NTuple{N, AbstractString};
            fonts::NTuple{N, AbstractString} = ("Roboto Medium", "Montserrat ExtraBold")
            bgcolours::NTuple{N, T} = (colorant"#a7bfc1", colorant"#5593c8"),
            textcolours::NTuple{N, T} = (colorant"white", colorant"white"),
            padding = 13,
            h = 50,
            ext = :pdf,
            filename = join(labels, "_") * ".\$ext",
            textsize = 20,
            showbadg = true
        )

        badge(labels...; kwargs...)


    Provided labels, font sizes and colours of the appropriate type,
    this function will create a badge in the style of (ForTheBadge)[https://forthebadge.com/].

    Input must be in the form of tuples.
    """
    function badge(
            labels;
            fonts = ("$(@__DIR__)../assets/fonts/Roboto-Medium.ttf", "$(@__DIR__)../assets/fonts/Montserrat-ExtraBold.otf"),
            bgcolours = (colorant"#a7bfc1", colorant"#5593c8"),
            textcolours = (colorant"white", colorant"white"),
            padding = 13,
            h = 50,
            ext = :pdf,
            filename = join(labels, "_") * ".$ext",
            textsize = 20,
            showbadge = true
        ) where N where T

        Drawing(800, h, :png) # initialize a dummy, in-memory drawing to get text extents

        fontsize(textsize) # set the font size

        rawextents = [begin fontface(fonts[i]); ceil(textextents(labels[i])[3]) + padding * 2 end for i in eachindex(labels)]
        finish()
        pushfirst!(rawextents, 0.0)

        extents = [sum(rawextents[1:i]) for i in eachindex(rawextents)]

        xlength = sum(rawextents)

        midpoints = ((rawextents[i]) / 2 + ((i == zero(typeof(i))) ? 0 : sum(rawextents[1:i-1])) for i in eachindex(extents)) |> collect

        Drawing(xlength, h, filename)

        for (k, p) in enumerate(midpoints[2:end])
            sethue(bgcolours[k])
            box(Point(extents[k], 0), Point(extents[k+1], 50), :fill)
            sethue(textcolours[k])
            fontface(fonts[k])
            fontsize(textsize)
            textoutlines(labels[k], Point(p, 25), halign=:center, valign=:middle)
            fillpreserve()
        end

        finish()

        showbadge && preview()

        filename
    end

    badge(labels...; kwargs...) = badge(Tuple(labels); kwargs...)

    export badge

end
