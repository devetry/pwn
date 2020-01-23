import os
import random

from flask import Flask, request, render_template
from jinja2 import Environment, FileSystemLoader, StrictUndefined, TemplateNotFound

app = Flask(__name__)

SITE_NAME = 'pwn.devetry.com'
app.jinja_env.globals['SITE_NAME'] = SITE_NAME
app.jinja_env.globals['SUGGEST_A_SCRIPT_LINK'] = 'https://github.com/devetry/pwn'

FRUITS = (
  'canteloupe', 'pineapple', 'apple', 'pear', 'cranberry', 'pumpkin', 'lemon',
  'lime', 'orange', 'grape', 'grapefruit', 'pomegranate', 'kumquat', 'tangerine',
  'clementine', 'banana', 'coconut', 'papaya', 'mango', 'apricot', 'plum', 'strawberry',
  'peach', 'cherry', 'blueberry', 'jamberry', 'nectarine', 'tangelo', 'kiwifruit',
  'watermelon', 'raspberry'
)

script_dir = os.path.join(os.path.dirname(__file__), 'scripts')
script_env = Environment(
  undefined=StrictUndefined,
  autoescape=False,
  keep_trailing_newline=True,
  loader=FileSystemLoader(script_dir),
)
script_env.globals['FRUITS'] = FRUITS
script_env.globals['SITE_NAME'] = SITE_NAME

SCRIPT_NAMES = script_env.list_templates(filter_func=lambda name: not name.startswith('_'))
SCRIPTS = [script_env.get_template(name).render() for name in SCRIPT_NAMES]

def random_script():
  return random.choice(SCRIPTS)

@app.route('/')
def index():
  if 'curl' in request.headers.get('User-Agent'):
    return random_script(), 200, {'Content-Type': 'text/plain; charset=utf-8'}
  return render_template('index.html', script_names=SCRIPT_NAMES)

@app.route('/<name>')
def script(name):
  try:
    compiled = script_env.get_template(name).render()
    found = True
  except TemplateNotFound:
    compiled = script_env.get_template('_list.sh').render(name=name, script_names=SCRIPT_NAMES)
    found = False
  if 'curl' in request.headers.get('User-Agent'):
    return compiled, 200, {'Content-Type': 'text/plain; charset=utf-8'}
  return render_template('detail.html', found=found, compiled=compiled, name=name)

if __name__ == '__main__':
  print (__file__)
  app.run()
