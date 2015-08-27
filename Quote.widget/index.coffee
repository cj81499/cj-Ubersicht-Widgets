command: 'curl -s "http://feeds.feedburner.com/brainyquote/QUOTEBR"'

refreshFrequency: 3600000

style: """
  bottom: 130px
  left: 10px
  font-family: Helvetica Neue
  color: white
  font-size:12px

.wrapper
    position: relative
    width: 380px
    height: 40px
    border: 1px solid rgba(white, 0.6)
    background: rgba(black, 0.2)

  .quote
    padding: 5px

  .author
    font-size: 10px
    opacity: 0.6
    float:right
    margin-top:25px
    margin-right:5px
"""

render: (output) -> """
<div class= "wrapper">
  <div class="author"></div>
<div class="quote"></div>
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
