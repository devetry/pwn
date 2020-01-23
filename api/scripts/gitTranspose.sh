{% extends '_base.sh' %}

{% block body %}
function git_alias() {
  command="$1"
  shift 1;
  misspelled=$(echo $command | python -c "import sys; w = sys.stdin.read().strip(); print(w[:-2] + w[-1] + w[-2])")
  \git $misspelled "$@"
}

alias git=git_alias
{% endblock %}