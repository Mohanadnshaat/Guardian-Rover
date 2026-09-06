function State_Code  = DecideRobotState(Front_Dist, Right_Dist, Left_Dist, Obstacle_Stable)

    if Obstacle_Stable && Front_Dist < 20
        State_Code = int32(4);
    elseif Obstacle_Stable && Front_Dist < 40 && Left_Dist > Right_Dist
        State_Code = int32(2);
    elseif Obstacle_Stable && Front_Dist < 40
        State_Code = int32(3);
    elseif Front_Dist >= 40
        State_Code = int32(1);
    else
        State_Code = int32(0);
    end
    
end