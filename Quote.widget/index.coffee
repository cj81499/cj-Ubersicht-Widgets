command: 'curl -s "http://feeds.feedburner.com/brainyquote/QUOTEBR"'

refreshFrequency: 3600000

style: """
  bottom: 130px
  left: 10px
  font-family: Helvetica Neue
  body.inverted &
      -webkit-filter invert(100%)

.wrapper
    position: relative
    line-height: 1
    width: 400px
    height: 40px
    position: relative
    overflow: hidden
    border: 1px solid rgba(white, 0.6)
    background: rgba(black, 0.2)

  .output
    padding: 2px 5px
    font-size: 8pt
    font-weight: lighter
	  font-smoothing: antialiased
    font-weight: 700

  .quote
    text-align: left
    font-weight: 500
    font-size: 11px
    color: white

  .author, .example, .example-meaning
    text-transform: none
    text-align: right
    font-weight: 200
    color rgba(white, 0.6)
    padding 2px 0px
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
