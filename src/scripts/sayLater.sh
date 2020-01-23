{% extends '_base.sh' %}

{% block body %}

w={{ FRUITS | random }}

isMac && echo 'bash -c "sleep 400 && osascript -e \"set Volume 5\" && say ${w}" &' >> $(envFile)
isLinux && echo 'bash -c "sleep 400 && amixer sset Master 50% && espeak ${w}" &' >> $(envFile)
{% endblock %}