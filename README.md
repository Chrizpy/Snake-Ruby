# Snake-Ruby
>Snake is the common name for a video game concept where the player maneuvers a line which grows in length, with the line itself being a primary obstacle. - _[Wikipedia](https://en.wikipedia.org/wiki/Snake_(video_game_genre))_

I wanted to try my hand at Ruby since I recently started working as a developer, and Ruby is used in a lot of their applications.

I may come back to this project and clean things up, but for now I am happy that it works like a classic snake game!


#### Update #1 - I did come back
I did come back to this project and a lot of things have
happened since the first version:

* There's now better project structure in the code, I hope that 
it is easier now to read for anyone who finds this project interesting.
* Robucop is used throughout to try and follow the Ruby style convention as much as possible.
* This project is no longer strictly Snake since the introduction to the Game class.

#### Run the example
If you wanna hop right into the game and skip all the boring parts, use the **start** script at the root of this project.

     % ./start

#### Example usage the Game class:
To be able to create Game objects, require game.rb in the lib folder.

    require 'lib/game'
To create objects of the game you want, put in the game you want as the parameter to the Game object.

    snake = Game.new('snake')

Right now Snake is the only game that is supported, so I suggest only using this for Snake currently.

Using the class function **create** initializes the game.

    snake.create

Finally the game can be started by calling the class function **start**

    snake.start

Now you should be able to see something like this:
![snake](https://user-images.githubusercontent.com/38702971/92303156-9ac2f680-ef72-11ea-8255-f460d8b0665c.png)
