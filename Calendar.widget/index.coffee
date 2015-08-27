sundayFirstCalendar = 'cal && date'

mondayFirstCalendar =  'cal | awk \'{ print " "$0; getline; print "Mo Tu We Th Fr Sa Su"; \
getline; if (substr($0,1,2) == " 1") print "                    1 "; \
do { prevline=$0; if (getline == 0) exit; print " " \
substr(prevline,4,17) " " substr($0,1,2) " "; } while (1) }\' && date'

command: sundayFirstCalendar

refreshFrequency: 360000

style: """
  bottom: 10px
  left: 90px
  height: 110px
  width: 130px
  color: white
  font-family: Helvetica Neue
  border: 1px solid rgba(white, 0.6)
  background: rgba(black, 0.2)
  font-size: 12px
  line-height: 1

  table
    border-collapse: collapse
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translateX(-50%) translateY(-50%);

  td
    text-align: center
    padding: 1px 1.5px

  .today
    background: rgba(white, 0.6)
    font-weight:bold

"""

render: -> """
  <wrapper>
    <table>
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

  thead.append "<tr><td colspan='7'>#{rows[0]}</td></tr>"
  tableRow = $("<tr></tr>").appendTo(thead)
  daysOfWeek = rows[1].split(/\s+/)

  for dayOfWeek in daysOfWeek
    tableRow.append "<td>#{dayOfWeek}</td>"

updateBody: (rows, table) ->
  tbody = table.find("tbody")
  tbody.empty()


  rows.splice 0, 2
  rows.pop()
  today = rows.pop().split(/\s+/)[2]

  for week, i in rows
    days = week.split(/\s+/).filter (day) -> day.length > 0
    tableRow = $("<tr></tr>").appendTo(tbody)

    if i == 0 and days.length < 7
      for j in [days.length...7]
        tableRow.append "<td></td>"

    for day in days
      cell = $("<td>#{day}</td>").appendTo(tableRow)
      cell.addClass("today") if day == today

update: (output, domEl) ->
  rows = output.split("\n")
  table = $(domEl).find("table")

  @updateHeader rows, table
  @updateBody rows, table
