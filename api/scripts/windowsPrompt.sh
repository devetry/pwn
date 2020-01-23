{% extends '_base.sh' %}

{% block body %}
cat << EOF >> $(envFile)
export PS1='C:${PWD////\\\\}> '
EOF
{% endblock %}