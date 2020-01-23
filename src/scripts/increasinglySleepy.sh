{% extends '_base.sh' %}

{% block body %}
ENV_FILE=$(envFile)
echo "echo \"sleep 1\" >> ${ENV_FILE}" >> $ENV_FILE
{% endblock %}