# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

alias cloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/'

alias codec='code ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/'

alias idp='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/Bachelorarbeit/IDP/'

alias la='ls -la'


platex(){

  # Argumente in Variablen speichern
  local filename="$1"
  # Prüfen, ob die Quelldatei existiert
  if [ ! -f "$filename.tex" ]; then
    echo "Error: Source file '$texfile.tex' does not exist."
    return 1
  fi

echo "1"
  pdflatex $filename".tex"
echo "2"
    biber $filename".bcf"
echo "3"
    pdflatex $filename".tex"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
