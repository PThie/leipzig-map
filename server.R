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
    # replace picture link with path if picture is privat

    poi <- poi |>
        mutate(
            picture = case_when(
                source_ind == "privat" ~ paste0(name, ".JPG"),
                TRUE ~ picture
            )
        )
    
    #--------------------------------------------------
    # define marker icons
    pointerIcon <- makeIcon(
        iconUrl = "pointer_large.png",
        iconWidth = 40,
        iconHeight = 40
    )

    #--------------------------------------------------
    # define label text for pop-ups
    label_text <- glue(
        "<h3 style = \"font-family:Calibri, sans-serif;\"><b>{poi$name}</b></h3>",
        "<p style = \"font-family:Calibri, sans-serif; font-size:140%; overflow-y:scroll; height:100px\">{poi$description}</p>",
        "<img src={poi$picture} width = 300px height = auto>",
        "<p style = \"font-family:Calibri, sans-serif;font-size:100%\">{poi$source}</p>"
    )

    #--------------------------------------------------
    # create map

    output$map <- renderLeaflet({
        leaflet() |>
            addProviderTiles(
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