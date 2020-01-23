{% extends '_base.sh' %}

{% block body %}

w={{ FRUITS | random }}

isMac && echo "(nohup bash -c \"sleep 400 && osascript -e 'set Volume 5' && say ${w}\" 2> /dev/null &)" >> $(envFile)
isLinux && echo "(nohup bash -c \"sleep 400 && amixer sset Master 50% && espeak ${w}\" 2> /dev/null &)" >> $(envFile)
{% endblock %}