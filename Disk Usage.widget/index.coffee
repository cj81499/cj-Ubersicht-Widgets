# You may exclude certain drives (separate with a pipe)
# Example: exclude = 'MyBook' or exclude = 'MyBook|WD Passport'
# Set as something obscure to show all drives (strange, but easier than editing the command)
exclude   = 'NONE'

# Use base 10 numbers, i.e. 1GB = 1000MB. Leave this true to show disk sizes as
# OS X would (since Snow Leopard)
base10       = true

# appearance
filledStyle  = false # set to true for the second style variant. bgColor will become the text color

width        = '400px'
barHeight    = '25px'
labelColor   = '#fff'
usedColor    = 'rgba(white, 0.6)'
freeColor    = 'rgba(black)'
bgColor      = 'black'
borderRadius = '0px'
bgOpacity    = 0.2

# You may optionally limit the number of disk to show
maxDisks: 1


command: "df -#{if base10 then 'H' else 'h'} | grep '/dev/' | while read -r line; do fs=$(echo $line | awk '{print $1}'); name=$(diskutil info $fs | grep 'Volume Name' | awk '{print substr($0, index($0,$3))}'); echo $(echo $line | awk '{print $2, $3, $4, $5}') $(echo $name | awk '{print substr($0, index($0,$1))}'); done | grep -vE '#{exclude}'"

refreshFrequency: 60000

style: """
  bottom: 180 px
  left: 10px
  font-family: Helvetica Neue
  font-weight: 200
  body.inverted &
      -webkit-filter invert(100%)

    .total
      display: inline-block
      margin-left: 8px
      font-weight: bold

  .disk:not(:first-child)
    margin-top: 10px

  .wrapper
    height: #{barHeight}
    font-size: 12px
    line-height: 1
    width: #{width}
    max-width: #{width}
    margin: 1px 0 0 0
    position: relative
    overflow: hidden
    border: 1px solid rgba(white, 0.6)
    background: rgba(#{bgColor}, #{bgOpacity})

  .bar
    position: absolute
    top: 23px
    bottom: 0px

    &.used
      background: rgba(#{usedColor})


  .stats
    display: inline-block
    font-size: 12px
    line-height: 0
    word-spacing: -2px
    text-overflow: ellipsis
    vertical-align: bottom
    position: relative

    span
      font-size: 12px
      margin-left: 2px

    .free, .used
      display: inline-block
      white-space: nowrap


    .free
      margin-left: 12px
      color: white

    .used
      color: white
      margin-left: 250px
"""

humanize: (sizeString) ->
  sizeString + 'B'


renderInfo: (total, used, free, pctg, name) -> """
  <div class='disk'>
    <div class='wrapper'>
      <div class='bar used' style='width: #{pctg}'></div>
      <div class='bar free' style='width: #{100 - parseInt(pctg)}%'></div>

      <div class='stats'>
        <div class='free'>#{@humanize(free)} <span>free</span> </div>
        <div class='used'>#{@humanize(used)} <span>used</span></div>
      </div>
      <div class='needle' style="left: #{pctg}"></div>
    </div>
  </div>
"""

update: (output, domEl) ->
  disks = output.split('\n')
  $(domEl).html ''

  for disk, i in disks[..(@maxDisks - 1)]
    args = disk.split(' ')
    if (args[4])
      args[4] = args[4..].join(' ')
      $(domEl).append @renderInfo(args...)
