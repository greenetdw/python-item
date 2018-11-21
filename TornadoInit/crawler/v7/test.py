import pytesseract
from PIL import Image

pytesseract.pytesseract.tesseract_cmd = 'E:\Python27\Scripts\pytesseract.exe'
tessdata_dir_config = '--tessdata-dir "E:\Python27\Scripts\tessdata"'

image = Image.open("tess_rrtgot.PNG")
code = pytesseract.image_to_string(image, config=tessdata_dir_config)
print(code)
