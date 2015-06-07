command: 'curl -s "http://feeds.feedburner.com/brainyquote/QUOTEBR"'

refreshFrequency: 3600000

style: """
  bottom: 130px
  left: 10px
  font-family: Helvetica Neue
  display:inline
  color: white
  font-size:12px

.wrapper
    position: relative
    width: 400px
    height: 40px
    overflow: auto
    border: 1px solid rgba(white, 0.6)
    background: rgba(black, 0.2)

  .output
    padding: 5px

  .author, .example, .example-meaning
    font-size: 10px
    opacity: 0.6
    padding-top: 2px
    float:right
"""

render: (output) -> """
<div class= "wrapper">
  <div class="output">
    <div class="quote"></div>
    <div class="author"></div>
  </div>
"""

update: (output, domEl) ->
  # Define constants, and extract the juicy html.
  dom = $(domEl)
  xml = jQuery.parseXML(output)
  $xml = $(xml)
  description = jQuery.parseHTML($xml.find('description').eq(1).text())
  $description = $(description)

 # Find the info we need, and inject it into the DOM.
  dom.find('.quote').html $xml.find('description').eq(2)
  dom.find('.author').html $xml.find('title').eq(2)
