echo "## Unable to find a script named {{ name }} ##"
echo
echo "available scripts:"
{% for script in script_names %}
echo " * {{ script }}"
{%- endfor %}
