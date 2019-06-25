import xlrd
from datetime import date

months = ["January", "February", "March", "April", "May", "June",
          "July", "August", "September", "October", "November", "December"]


def dateparser(data):
    current_year = date.today().year
    date_list = data.split(' ')
    date_list[0] = date_list[0].split('-')
    date_list.append(date_list[0][1][:-2])
    date_list.remove(date_list[0])
    for st in date_list:
        if st == '':
            date_list.remove(st)
    food_date = date(current_year, months.index(date_list[0])+1, int(date_list[1]))
    return food_date


def food_plan_cell(sheet):
    plan_value = []
    for i in range(sheet.nrows):
        if sheet.cell_value(i, 1).upper() in ['BREAKFAST', 'LUNCH', 'SNACKS', 'DINNER']:
            plan_value.append(i)
    return plan_value


def yield_food_items(file):
    wb = xlrd.open_workbook(file)
    sheet = wb.sheet_by_index(0)
    food_phase = food_plan_cell(sheet)
    for i in range(1, sheet.ncols):
        food_date = dateparser(sheet.cell_value(2, i))
        current_plan = "BREAKFAST"
        for j in range(food_phase[0]+2, sheet.nrows):
            if j in food_phase:
                current_plan = sheet.cell_value(j, 1)
                continue
            if sheet.cell_value(j, i) == '':
                continue
            yield [sheet.cell_value(j, i), food_date, current_plan]
