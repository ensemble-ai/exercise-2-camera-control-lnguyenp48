# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Jacob Nguyen 
* *email:* jtpnguyen@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera is always centered on the vessel. There is a 5 by 5 unit cross on the center of the screen.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The box is constantly moving in the z-x plane. The vessel is able to move around in the box that is constantly moving. The vessel gets pushed by the left edge of the box if it is lagging behind. The vessel cannot leave the box in any x or z direction. There is a frame border box.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
When the vessel moves, the vessel moves ahead of the camera. The camera follows the vessel at follow_speed. When the vessel stops, the camera catches up to the vessel at catchup_speed. The vessel cannot be more than leash_distance units away from the camera. When the vessel comes back to the center of the camera, the vessel does not snap and the transition is very smooth. There is a 5 by 5 unit cross on the center of the screen.

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [x] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
One major flaw would be that the camera does not work if more than one input are processed before the camera comes back to the center of the camera. For example, if you press W and then press D before the vessel reaches the center of the camera, the vessel gets stuck in place. This is better seen if you press a combination of inputs such as W and A and then hold down D. The vessel gets stuck in the corner and does not move to the left. Additionally, another major flaw would be that the timer only works once. Other than that, if you wait for the vessel to catch up then the camera does work. The camera moves in the direction of the input at lead_speed and catches up to the vessel at catchup_speed when the vessel stops. The vessel cannot be more than leash_distance units away from the camera. There is a 5 by 5 unit cross at the center of the screen.

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [x] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
One major flaw is that when the vessel is in the speedup zone, the camera moves in the opposite direction that the vessel is going. Another major flaw would be the implementation of the speedup zone that is supposed to speedup the camera in the x direction and z direction seperately. For example, if the vessel is in the speedup zone, moving in the x direction, but touching the top edge of the pushbox, the camera should move at push_ratio in the x direction but at full speed in the z direction. The implementation of the speedup zone is set up such that the checks for speeding up in the x or z direction are split up into quadrants like a tic tac toe board. The corner quadrants speed up the vessel in both the x and z directions no matter what the input is. For example, the top left quadrant will only speed up the vessel to the right and downwards. If the quadrant is a not a corner quadrant then it will only speed it up in one direction no matter what the input is. For example, the quadrant in between the top left and bottom left quadrant will only speed the vessel up to the right even if other directions are inputted. Other than these flaws, the camera meets the other requirements. The camera does not move in the inner-most area. The camera moves at full speed in one direction when it touches a side of the pushbox. The camera moves at full speed in both the x and z directions when it touches a corner of a pushbox. A minor flaw would be that draw_logic() draws both the speedup zone and pushbox when it is only supposed to draw the pushbox.
___
# Code Style #

Style guide: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html

### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####

One example of a [comment](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/auto_scroll.gd#L44) that is not disabled code and does not begin with a space.

Does not use one blank line to seperate [this line of code](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/lerp_leading.gd#L36) and the logical section above it. The same happens [here](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/lerp_leading.gd#L40).

[tpos](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/auto_scroll.gd#L29) and [cpos](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/auto_scroll.gd#L30) should be defined closer to [where](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/auto_scroll.gd#L41) they are used.

#### Style Guide Exemplars ####

The code does a good job at using [private variables](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/auto_scroll.gd#L9) and ensuring that they come after export variables which is the proper order according to the style guide.

I could not find any lines of code that were over 100 characters.

This [private function](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/lerp_leading.gd#L87) starts with an underscore.

Uses snake_case for functions and variables and uses PascalCase for class and node names.

___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

Some [variables](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/pos_lock_lerp.gd#L28) are not type hinted.

This variable name [speed_left_edge](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/four_way_push.gd#L38) can be confusing as it can be read as the speed of the left edge. This goes for the other variables that deal with the other directions for the speedup zone.

These [variables](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/lerp_leading.gd#L58) are type hinted as floats but are divided by an integer. This happens in lerp_leading.gd, pos_lock_lerp.gd, and pos_lock.gd.

#### Best Practices Exemplars ####

The code is very well documented with [comments](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/auto_scroll.gd#L32) that explain what each block of code does.

When used, [velocity](https://github.com/ensemble-ai/exercise-2-camera-control-lnguyenp48/blob/865fcc9f7dde09e6965db3a0c446e90192850802/Obscura/scripts/camera_controllers/lerp_leading.gd#L36) is multiplied by delta.

There are many commits on the repository and a change log in README.md.
