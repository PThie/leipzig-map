server <- function(input, output) {
    #--------------------------------------------------
    # read data

    dta <- openxlsx::read.xlsx(
        "raw_data.xlsx"
    )

    # make it spatial
    poi <- sf::st_as_sf(
        dta,
        coords = c("longitude", "latitude"),
        crs = 4326,
        remove = FALSE
    )

    #--------------------------------------------------
    # define marker icons
    pointerIcon <- makeIcon(
        iconUrl = "assets/pointer_large.png",
        iconWidth = 40,
        iconHeight = 40
    )

    #--------------------------------------------------
    # define label text for pop-ups
    label_text <- glue(
        "<h3 style = \"font-family:open sans;\"><b>{poi$name}</b></h3>",
        "<p style = \"font-family:open sans;font-size:150%\" align = \"justify\">{poi$description}</p>",
        "<img src={poi$picture} width = 300px height = auto>",
        "<p style = \"font-family:open sans;font-size:100%\">{poi$source}</p>"
    )

    #--------------------------------------------------
    # create map

    output$map <- renderLeaflet({
        leaflet() |>
            addProviderTiles(
                # providers$Esri.WorldGrayCanvas,
                # providers$CartoDB.DarkMatterNoLabels,
                # providers$Stamen.TonerLite,
                providers$Esri.WorldTopoMap,
                options = providerTileOptions(noWrap = TRUE)
            ) |>
            setView(12.39071794006535, 51.345641678880185, zoom = 13) |>
            addMarkers(
                data = poi,
                icon = pointerIcon,
                popup = label_text
            )
    })
}