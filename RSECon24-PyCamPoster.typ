#set page(
  paper: "a0",
  margin: (x: 1.5cm, y: 1.5cm),
)

#set text(
  font: "Noto Sans Display"
)

#show <title>: set text(size: 50pt, weight : "bold")
#show <authors>: set text(size: 30pt, weight: "regular")
#show <contact>: set text(size: 22pt, weight: "regular")
#show <box_title>: set text(size: 35pt, weight: "semibold")
#show <caption>: set text(size: 22pt, weight: "light", style: "italic")
#show "SO2": [SO#sub[2]]

#show <body_text>: it =>{
  set text(size: 24pt, tracking: 0.5pt, spacing: 150%)
  set par(leading: 1.15em)
  set block(below: 1.75em)
  it
}

#show heading: it => {
  set text(fill: white)
  set align(horizon + left)
  pad(left: 1%)[#it]
} 

#let sheff_purple = rgb("#6933AD")

#let title_box_height = 10cm
#let heading_box_height = 2.5cm
#let v_gap = 0.7cm

#let title_box(height: 10cm, title, authors, contact) = {
  box(
    fill: sheff_purple,
    stroke: 2pt + black,
    grid(
      rows: height,
      columns: (0.7fr, 0.2fr, 0.1fr),
      align: horizon,
      inset: (right: 1%),
      [
        = #title <title>
        === #authors  <authors>
        ==== #contact <contact>
      ],
      image("TUOS_Logo_white.png", width: 90%),
      image("rse_logo.png", width: 70%), 
      )
  )
}

#let content_box_title(heading) = {
  box(width: 100%, height: 100%, fill: sheff_purple, stroke: (bottom: 2pt + black))[
    = #heading <box_title>
  ]
}

#let inner_content_box(content) = {
  box(width: 100%, height: 100%, inset: (x: 1em, y: 2em))[
    #content <body_text>
  ]
}

#let outer_content_box(header, content, body_length: 10cm) = {
  box(
    stroke: 2pt +black,
    grid(
      rows: (heading_box_height, body_length),
      content_box_title[#header],
      inner_content_box[#content]
    )
  )
}


#let title = "Developing PyCam: Software for acquiring and processing volcanic UV SO2 camera data"
#let authors = ("Daniel Brady", "Thomas Wilkes", "Tom Pering")
#let contact = "daniel.brady@sheffield.ac.uk"

#let processing_stages_alt = "A flowchart showing the process of analyzing image data with spectrometer inputs. The image data undergoes pre-processing and differential optical depth calculation. This is then calibrated using SO2 column density from the spectra, leading to the generation of a velocity field and emission rates."

#let picam_hardware_alt = "Two labeled images showing the internal and external components of a portable scientific instrument. Image A displays the interior, including a spectrometer, Raspberry Pis, SSD, GPS, as wel as various other components, cables and optics. Image B shows the exterior with labeled lenses for the spectrometer, off-band camera, and on-band camera."

#let picam_remote_alt = "Remote solar-powered camera setup in a barren, rocky landscape under a bright blue sky with scattered clouds. The equipment includes solar panels and a small box on a tripod, with cables connecting them. The horizon shows a distant, flat terrain with minimal vegetation"

#let picam_locations_alt = "Grayscale map of the world indicating the locations of PiCam setups with green, yellow and orange markers."

#let pycam_alt = "Screenshot of a user interface. The right third of the image consists of settings boxes and toggles at the top, the lower part of this side contains an image of the volcano and a line graph with two lines. The left two-thirds of the image consists of four stacked line graphs dipslaying the output from processing. The top two graphs have multiple lines with different colours, while the lower two have only single lines."

#let bg_content = [
  Gas emissions are one of the key ways in which volcanologists are able to determine the state of a particular volcanic system, and potentially provide a means of hazard forecasting @SPARKS2003. Of the gases emitted, Sulphur Dioxide (SO2) is one of the easier species to detect with remote sensing instruments; primarily due to its relatively low atmospheric concentrations and strong distinctive absorption bands at ultraviolet (UV) and infrared (IR) wavelengths.
  
  One approach for measuring SO2 emissions is through the use of ground-based UV sensitive cameras, achieved by equipping cameras with band-pass filters to capture images in ~310 nm and ~330 nm UV bands, corresponding to wavelengths with high and low SO2 absorption, respectively. Taken together, these images are able to provide a measure of the optical depth for a volcanic plume, which can then be calibrated with data from an on-board spectrometer to provide estimates of SO2 concentration within the plume.

  #align(center)[
    #box(height: 15cm, width: 22cm)[
      #image("processing_stages.jpg", height: 100%, alt: processing_stages_alt)
      #[Schematic from #cite(<KERN2015>, form: "prose") showing the processing pipeline for estimating SO2 emission rates using a UV camera] <caption>  
    ]
  ]
]

#let hw_content = [
  While UV SO2 cameras provide a high degree of temporal and spatial resolution for measuring volcanic emissions, their usage has been limited. This is partly due to the cost of the instrumentation, which until recently has relied on scientific-grade UV camera typically costing >10000 USD each.

  The PiCam system developed by #cite(<WILKES2017>, form: "prose") addresses the restrictive cost of such systems through the use of modified Raspberry Pi camera modules. Removal of the Bayer filter enhances UV sensitivity of the camera module to create a low-cost UV camera alternative, aiding proliferation of such equipment to hazardous volcanoes around the globe.

  #box(height: 15.5cm,
    columns(2)[
      #set align(center)
      #image("PiCam_hardware.jpg", height: 13cm, alt: picam_hardware_alt)
      #[PiCam Internals (from #cite(<WILKES2023>, form: "prose"))] <caption>
      #image("PiCam_remote.jpg", height: 13cm, alt: picam_remote_alt)
      Permanent PiCam deployed at Kīlauea, Hawaii <caption>
    ]
  )

  To date, 6 PiCam systems are installed on active volcanoes around the world (Lascar, Chile; Lastarria, Chile; Cotopaxi, Ecuador; Reventador, Ecuador; Kīlauea, Hawaii; Merapi, Indonesia).

  #set align(center)
  #box(width: 90%)[
    #image("PiCam_locations.jpg", alt: picam_locations_alt)
    Locations of current or planned permanent deployments of PiCam  <caption>  
  ]
]

#let sw_content = [
  PyCam (#text(fill: blue)[_github.com/twVolc/PyCamPermanent_]) began development in 2019 as a free and open source software package to complement the PiCam hardware. It is built using Python 3 and provides a Tk-based GUI interface as a user-friendly means of setting up data acquisition and processing the data captured.  

  #align(center)[
    #image("PyCam.jpg", width: 80%, alt: pycam_alt)
    Screenshot of PyCam processing data collected from Lascar, Chile <caption>
  ]

  The data acquisition functionality of the software allows for manual acquisition during setup of the instrument, scheduling of data acquisition, and configuration of automated data acquisition.

  The software allows both on- and off-line processing of the spectra and images captured. In order to process this data, PyCam provides an interface for established volcanic gas libraries, including pyplis @GLISS2017, ifit @ESSE2020, and light dilution correction @VARNAM2020. It also incorporates other methods for estimating emission rates (e.g. The plume speed alogrithm from #cite(<NADEAU2001>, form: "prose")) 
]

#let rse_content = [
  I began working on PyCam in Feb 2023, and have worked on it for approximately 16 months over two stints. My overarching goal has been to enchance the reproducibility, stability and usability of the software.
  
  *Direct contributions:*
  - Improved installation procedure and documentation
  - Added configuration files that specify settings for a processing run
  - Extended output to include additional data and meta-data files (e.g. calibration, configuration)
  - Fixed real-time processing so it works over multiple days
  - Added ancillary code to make feature development easier (e.g. script for mocking data transfer, container simulating FTP on a Raspberry Pi)
  
  *Indirect contributions:*
  - Better version control practices (use of branches and pull requests)
  - Use of issues to record and communicate features/problems
  - Use of releases and release notes to describe changes to the code
]

#let roadmap_content = [
  Software goals:
  - Improve logging
  - Disentangle the front- and back-end of the software, with the aim of GUI-less deployment
  - Developing the testing suite and setting up continuous integration
  
  Project goals:
  - Next generation of PiCam (using Raspberry Pi 5)
  - Develop data acquisition and processing pipeline
]

#let conclusion_content = [
  Overall, the impact of having an RSE on the project has been to allow the other team members to focus on scientific goals, knowing that the software side is in competent hands. It has also meant that development of the software has been accelerated, making something that is stable and usable for global collaborators.
  
  Most notably, the code development has allowed near-real-time data to be displayed (since July 2024) in the monitoring observatory of Mount Merapi (BPPTKG headquarters), one of the most hazardous volcanoes in the world. Such work could therefore greatly impact hazard assessment at volcanoes where the PiCam instrument is installed.
]


#title_box(height: title_box_height)[#title][#authors.join(", ")][#contact]
#v(0.5cm)
#box(
  height: 97cm,
  columns(2, gutter: 1cm)[
    #outer_content_box(body_length: 38.5cm)[Background][#bg_content]
    #v(v_gap)
    #outer_content_box(body_length: 52cm)[PiCam Hardware][#hw_content]

    #outer_content_box(body_length: 40cm)[PyCam Software][#sw_content]
    #v(v_gap)
    #outer_content_box(body_length: 23.5cm)[RSE Contributions][#rse_content]
    #v(v_gap)
    #outer_content_box(body_length: 12cm)[Roadmap][#roadmap_content]
    #v(v_gap)
    #outer_content_box(body_length: 13.5cm)[Conclusions][#conclusion_content]
    #inner_content_box[
      #set align(center)
      Poster Github Repo: #text(fill: blue)[github.com/ubdbra001/RSECon24_Poster]
    ]
  ]
)

#box(width: 40cm)[
  #bibliography("biblio.bib", style: "harvard-cite-them-right")
]
