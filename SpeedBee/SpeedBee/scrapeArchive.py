import requests
from bs4 import BeautifulSoup

letters = open("all_letters.txt", "w")
pangrams = open("all_pangrams.txt", "w")

def findLetters(soup):
    letters_line = soup.find('input', placeholder="7 unique letters")
    htmlLineAsList = []
    for char in str(letters_line):
        htmlLineAsList.append(char)
    finalWord = ""
    for i in range(0, len(htmlLineAsList)):
        if i > 107:
            if i < 115:
                finalWord += htmlLineAsList[i]
    letters.write(finalWord.upper() + "\n")

def findPangrams(lines):
    for line in lines:
        if line == "word":
            page_pangrams = lines[lines.index(line) - 4]

            if "," in page_pangrams:
                pagePangramsList = page_pangrams.split(",")
                for pangram in pagePangramsList:
                    # adds commas to words on the same line
                    if pagePangramsList.index(pangram) == len(pagePangramsList) - 1:
                        pangrams.write(pangram + "\n")
                    else:
                        pangrams.write(pangram + ",")
            else:
                pangrams.write(page_pangrams + "\n")


def main():
    for i in range(1, 2240):
        print("page: " + str(i))

        # reading the page
        url = "https://www.sbsolver.com/s/" + str(i)
        response = requests.get(url)
        html_content = response.content
        soup = BeautifulSoup(html_content, "html.parser")
        text_content = soup.get_text()
        lines = text_content.split("\n")

        findLetters(soup)
        findPangrams(lines)

main()
