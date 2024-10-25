#!python3

import tkinter as tk
from tkinter.messagebox import showinfo
from functools import partial
from random import sample
import time
import os
import uuid
import sqlite3


db_path = os.path.expanduser("~/Desktop/mathQuiz.db")


def initDB():
    # create a sqlite3 database in '~/Desktop/mathQuiz.db'
    # create a table quiz
    # {
    #   id , # number, unique  autoIncreament
    #   quizId, # text
    #   question,  # text
    #   answer, # number
    #   correct, # number
    #   timeElapse , # number
    #   date, # text
    # }
    #
    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    c.execute(
        """CREATE TABLE IF NOT EXISTS quiz (
        id integer PRIMARY KEY AUTOINCREMENT,
        quizId text NOT NULL,
        question text NOT NULL,
        answer integer NOT NULL,
        correct BOOLEAN NOT NULL,
        timeElapse integer NOT NULL,
        date text NOT NULL
        ) """
    )


initDB()


def say(msg="Finish"):
    os.popen(f'say "{msg}"')


# constant
nQuestion = 20

# variables
score = 0
questionIndex = 0
startTime = 0
questionStartTime = 0
quizId = 0

# window
win = tk.Tk()
win.title("数学练习 减法 L1")

screen_width = win.winfo_screenwidth()
screen_height = win.winfo_screenheight()

WIDTH = screen_width * 3 // 4
HEIGHT = screen_height * 5 // 6

# WIDTH, HEIGHT = 400, 320  # debug
# nQuestion = 2  # debug

win.geometry(f"{WIDTH}x{HEIGHT}")


# a large are to display the entire question, and below it there are 4 bottons for 4 answers
# the question is randomly generated

subTitle = tk.Label(win, text=f"0/{nQuestion}", font=("Arial", WIDTH // 15), bg="cyan")
subTitle.pack(side="top", fill="x")

question = tk.Label(win, text="请点击'再来一局'", font=("Arial", WIDTH // 10))
question.pack(expand=True, fill="both")


btn_answers = []


def init():
    global score, questionIndex, startTime, quizId, questionStartTime
    score = 0
    questionIndex = 0
    startTime = time.time()
    questionStartTime = startTime
    quizId = uuid.uuid4().hex
    for btn in btn_answers:
        # disable btn
        btn.config(state="disabled")


def showlast20records():
    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    c.execute(
        "SELECT id, question, answer, correct, timeElapse FROM quiz ORDER BY id DESC LIMIT 20"
    )
    records = c.fetchall()
    records.reverse()

    qs = []
    for i, record in enumerate(records):
        id, question, answer, correct, timeElapse = record
        mark = "✔️" if correct else "❌"
        qs.append(f"{i+1:2d}:  {question} = {answer}  {mark}  用时:{timeElapse:.2f}")

    showinfo("last 20 records", "\n".join(qs))

    # now you can re-start the quiz
    btn_start.config(state="normal")


def finishQuiz():
    question.config(text=f"你的得分是:{score}\n共用时:{time.time() - startTime:.2f}秒")
    for btn in btn_answers:
        # disable btn
        btn.config(state="disabled")

    win.after(1000, showlast20records)


def newQuestion():
    global questionIndex, questionStartTime

    subTitle.config(text=f"{questionIndex+1}/{nQuestion}")

    # operand1 op1 operand2 op2 operand3 = result

    # first random generate 2 operators from + -
    op1 = "-"

    while True:
        operand1 = sample(range(30, 90), 1)[0]
        singleDigit = operand1 % 10
        if singleDigit == 0 or singleDigit == 9:
            singleDigit = 1
        operand2 = sample(range(singleDigit + 1, 10), 1)[0]

        # calculate the result
        result = eval(f"{operand1}{op1}{operand2}")
        if True:
            # show question
            question.config(
                text=f"{operand1:2d} {op1} {operand2:2d} = ?",
                bg="white",
            )
            fakeAnswers = [result - 2, result - 1, result + 1, result + 2]
            if result > 10:
                fakeAnswers += [result - 10, result - 9, result - 11]
            elif result < 10:
                fakeAnswers += [result + 10, result + 9, result + 11]

            if result in fakeAnswers:
                fakeAnswers.remove(result)

            # remove negative answer
            fakeAnswers = [x for x in fakeAnswers if x >= 0]

            if len(fakeAnswers) < len(btn_answers):
                continue

            # set questionStartTime
            questionStartTime = time.time()

            answer_options = sample(list(set(fakeAnswers)), 3)
            answer_options.append(result)
            # shuffle answer_options
            answer_options = sample(answer_options, 4)

            # print(answer_options)
            # assign answer_options to 4 bottons
            for i in range(4):
                btn_answers[i].config(text=answer_options[i], state="normal")

            break
    pass


# 4 bottons for 4 answers
def answer_click(btn_index):
    global score, questionIndex

    # disable btn_answers
    for btn in btn_answers:
        btn.config(state="disabled")

    q = question.cget("text")[:-3]
    correct_answer = eval(q)
    picked_answer = int(btn_answers[btn_index].cget("text"))

    correct = correct_answer == picked_answer
    if correct:
        question.config(text=":)")
        score += 1
        voices = ["Perfect.", "Great.", "Excellent.", "Well Done."]
        say(sample(voices, 1)[0])
    else:
        question.config(text=":(")
        voices = ["Keep Going.", "Try Again.", "You Can Do It.", "Don't Give Up."]
        say(sample(voices, 1)[0])

    # save to db
    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    c.execute(
        "INSERT INTO quiz ( quizId, question, answer, correct, timeElapse, date) VALUES (?, ?, ?, ?, ?, ?)",
        (
            quizId,
            q,
            picked_answer,
            correct,
            time.time() - questionStartTime,
            time.strftime("%Y-%m-%d %H:%M:%S"),
        ),
    )
    conn.commit()

    questionIndex += 1

    if questionIndex >= nQuestion:
        win.after(2000, finishQuiz)
    else:
        win.after(1000, newQuestion)


for i in range(4):
    answer = tk.Button(
        win,
        text="0",
        font=("Arial", WIDTH // 15),
        command=partial(answer_click, i),
    )
    answer.pack(side="left", expand=True, fill="x")
    btn_answers.append(answer)


def start_click():
    init()
    for btn in btn_answers:
        # enable btn
        btn.config(state="normal")
    btn_start.config(state="disabled")

    newQuestion()


btn_start = tk.Button(
    win,
    text="再来一局",
    fg="blue",
    font=("Arial", WIDTH // 15),
    command=start_click,
)
btn_start.place(x=0, rely=0.03)

init()


# mainloop
win.mainloop()
