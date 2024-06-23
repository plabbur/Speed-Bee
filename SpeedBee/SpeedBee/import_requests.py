import requests
from bs4 import BeautifulSoup

# letters = open("all_letters.txt", "w")
pangrams = open("all_pangrams.txt", "w")

# # list of letters
# for i in range(2018, 2025):
#     for j in range(1, 13):
#         # reading the page
#         url = "https://www.sbsolver.com/archive/" + str(i) + "/0" + str(j) if j < 10 else "https://www.sbsolver.com/archive/" + str(i) + "/" + str(j)
#         response = requests.get(url)
#         html_content = response.content
#         soup = BeautifulSoup(html_content, "html.parser")
#         text_content = soup.get_text()
#         lines = text_content.split("\n")

#         # filtering the words on the page & writing the necessary words to the file
#         for line in lines:
#             current_string = ""
#             if len(line) == 15:
#                 for char in line:
#                     if not char.isdigit() and not char.isspace():
#                         current_string += char
#                 letters.write('"' + current_string + '", ')

pangramsList = []
words = []

def readPage(num):
    url = "https://www.sbsolver.com/s/" + str(num)
    response = requests.get(url)
    html_content = response.content
    soup = BeautifulSoup(html_content, "html.parser")
    text_content = soup.get_text()
    return text_content.split("\n")

for i in range(1, 2212):
    print("page: " + str(i))
    lines = readPage(i)

    for line in lines:
        if line == "word":
            page_pangrams = lines[lines.index(line) - 4]
            pangramsList.append(page_pangrams)

            if "," in page_pangrams:
                words.append(page_pangrams.split(","))
            else:
                words.append(page_pangrams)

    if i % 500 == 0:
        fileName = open("pangrams_" + str(i) + ".txt", "w")
        fileName.write(str(words))

pangrams.write(str(words))