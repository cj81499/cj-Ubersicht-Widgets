command: 'cal && date "+%-m %-d %y"'

#Set this to true to enable previous and next month dates, or false to disable
otherMonths: true

refreshFrequency: "10m"

style:"""
  bottom: 10px
  left: 90px
  height: 110px
  width: 131px
  color: white
  font-family: Helvetica Neue
  border: 1px solid rgba(white, 0.6)
  background: rgba(black, 0.2)
  font-size: 12px
  line-height: 1

  wrapper
    display: table-cell
    vertical-align: middle
    display: table cell;
    height: 110px
    width: 131px

  table
    width: calc(100% - 4px)
    margin 0 auto
    border-collapse: collapse

  thead .monthAndYear
    // padding-bottom: 2px
    font-weight: bold

  thead .dayOfWeek
    padding-bottom: 2px

  td
    text-align: center
    padding: 1px 0px 0px

  .today
    background: rgba(white, 0.6)
    font-weight: bold

  .other_month
    color: rgba(white, 0.6)
"""

render: ->
  """
  <wrapper>
    <table cellpadding="0">
      <thead>
      </thead>
      <tbody>
      </tbody>
    </table>
  </wrapper>
  """

updateHeader: (rows, table) ->
  thead = table.find("thead")
  thead.empty()

  thead.append "<tr><td class='monthAndYear' colspan='7'>#{rows[0]}</td></tr>"
  tableRow = $("<tr></tr>").appendTo(thead)
  daysOfWeek = rows[1].split(/\s+/)

  for dayOfWeek in daysOfWeek
    tableRow.append "<td class='dayOfWeek'>#{dayOfWeek}</td>"

updateBody: (rows, table) ->
  #Set to 1 to enable previous and next month dates, 0 to disable
  PrevAndNext = 1

  tbody = table.find("tbody")
  tbody.empty()

  rows.splice 0, 2
  rows.pop()

  today = rows.pop().split(/\s+/)
  month = today[0]
  date = today[1]
  year = today[2]

  lengths = [31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30]
  if year%4 == 0
    lengths[2] = 29

  for week, i in rows
    days = week.split(/\s+/).filter (day) -> day.length > 0
    tableRow = $("<tr></tr>").appendTo(tbody)

    if i == 0 and days.length < 7
      for j in [days.length...7]
        if @otherMonths == true
          k = 6 - j
          cell = $("<td>#{lengths[month-1]-k}</td>").appendTo(tableRow)
          cell.addClass("other_month")
        else
          cell = $("<td></td>").appendTo(tableRow)

    for day in days
      cell = $("<td>#{day}</td>").appendTo(tableRow)
      cell.addClass("today") if day == date

    if i != 0 and 0 < days.length < 7 and @otherMonths == true
      for j in [1..7-days.length]
        cell = $("<td>#{j}</td>").appendTo(tableRow)
        cell.addClass("other_month")

update: (output, domEl) ->
  rows = output.split("\n")
  table = $(domEl).find("table")

  @updateHeader rows, table
  @updateBody rows, table
