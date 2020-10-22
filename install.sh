echo "-->to be install components..."
dnf install epel-release
dnf install vim git curl ctags git gcc gcc-c++ make readline readline-devel readline-staticsud openssl openssl-devel openssl-static sqlite-devel bzip2-devel bzip2-libs wget patch cmake make net-tools htop tree iftop libffi-devel graphviz* -y

# install pyenv
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

# set path
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /root/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /root/.bashrc
echo 'eval "$(pyenv init -)"' >> /root/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> /root/.bashrc
# wget http://mirrors.sohu.com/python/3.5.2/Python-3.5.2.tar.xz  -P ~/.pyenv/cache
export PYTHON_CONFIGURE_OPTS="--enable-shared"
source /root/.bashrc && pyenv install 3.5.2
mkdir -p ~/.pip
echo -e '[global]\ntrusted-host = pypi.douban.com\nindex-url = http://pypi.douban.com/simple' > ~/.pip/pip.conf
## virtualenv
/root/.pyenv/bin/pyenv virtualenv 3.5.2 py3
cd /home && echo 'py3' >> .python-version
#/root/.pyenv/versions/3.5.2/envs/py3/bin/pip install pylint
/root/.pyenv/versions/3.5.2/envs/py3/bin/pip install flake8
/root/.pyenv/versions/3.5.2/envs/py3/bin/pip install autopep8


echo "-->move vimrc to location..."
cp -f vimrc ~/.vimrc

echo "-->download vundle to manage vim plugins..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle
git clone git://github.com/tomasr/molokai.git ~/.vim/bundle
git clone git://github.com/vim-scripts/phd.git ~/.vim/bundle
git clone git://github.com/Lokaltog/vim-powerline.git ~/.vim/bundle
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim
git submodule add https://github.com/octol/vim-cpp-enhanced-highlight.git bundle/syntax/
git clone git://github.com/nathanaelkane/vim-indent-guides.git ~/.vim/bundle
git clone git://github.com/preservim/nerdtree.git ~/.vim/bundle
git clone git://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle

# 安装vim插件
vim -c PluginInstall -c q -c q
# 安装插件运行需要依赖的一些组件
cd /root/.vim/bundle/YouCompleteMe/ && python install.py --clang-complete

