## Installation
I prefer not to use additional programs like *stow*, so I use just:
```sh
$ ln -s /home/{username}/dotfiles/{package} /home/{username}/.config
```


### Nvim
To install all plugins write this inside nvim

```nvim
:PackerSync
```

### Fonts 
```sh
$ ln -s /home/{username}/dotfiles/other/fonts /home/{username}/.local/share/fonts
```

## License
Licensed under [The MIT License](https://opensource.org/license/mit/)
