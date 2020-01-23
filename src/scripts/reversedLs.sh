{% extends '_base.sh' %}

{% block body %}
echo "alias ls='ls | rev'" >> $(envFile)
{% endblock %}