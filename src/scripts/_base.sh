function envFile() {
  local SHELL=$(finger $USER | grep 'Shell:' | cut -f3 -d':')
  if [[ $SHELL =~ "zsh" ]]; then
    echo "${HOME}/.zshrc"
  else
    echo "${HOME}/.bashrc"
  fi
}

function isLinux() {
  uname -s | grep -i "linux"
  exit $?
}

function isMac() {
  uname -s | grep -i "darwin"
  exit $?
}

echo "
# You've been pranked by a friend or coworker!
#
# It seems you left a computer logged-in and unattended, and
# someone decided to teach you a lesson in Operational
# Security!
#
# See https://{{ SITE_NAME }} for more information
# ----- Beginning of modifications -----" >> $(envFile)
{% block body %}
{% endblock body %}
echo "
# ----- End of modifications -----" >> $(envFile)
