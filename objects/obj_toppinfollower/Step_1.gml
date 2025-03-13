switch (pizzakin)
{
    case 2:
        if (variable_global_exists("pizzakin1") && instance_exists(global.pizzakin1))
            followid = global.pizzakin1;
        else
            followid = playerid;
        
        break;
    
    case 3:
        if (variable_global_exists("pizzakin2") && instance_exists(global.pizzakin2))
            followid = global.pizzakin2;
        else if (variable_global_exists("pizzakin1") && instance_exists(global.pizzakin1))
            followid = global.pizzakin1;
        else
            followid = playerid;
        
        break;
    
    case 4:
        if (variable_global_exists("pizzakin3") && instance_exists(global.pizzakin3))
            followid = global.pizzakin3;
        else if (variable_global_exists("pizzakin2") && instance_exists(global.pizzakin2))
            followid = global.pizzakin2;
        else if (variable_global_exists("pizzakin1") && instance_exists(global.pizzakin1))
            followid = global.pizzakin1;
        else
            followid = playerid;
        
        break;
    
    case 5:
        if (variable_global_exists("pizzakin4") && instance_exists(global.pizzakin4))
            followid = global.pizzakin4;
        else if (variable_global_exists("pizzakin3") && instance_exists(global.pizzakin3))
            followid = global.pizzakin3;
        else if (variable_global_exists("pizzakin2") && instance_exists(global.pizzakin2))
            followid = global.pizzakin2;
        else if (variable_global_exists("pizzakin1") && instance_exists(global.pizzakin1))
            followid = global.pizzakin1;
        else
            followid = playerid;
        
        break;
    
    case 6:
        if (variable_global_exists("pizzakin5") && instance_exists(global.pizzakin5))
            followid = global.pizzakin5;
        else if (variable_global_exists("pizzakin4") && instance_exists(global.pizzakin4))
            followid = global.pizzakin4;
        else if (variable_global_exists("pizzakin3") && instance_exists(global.pizzakin3))
            followid = global.pizzakin3;
        else if (variable_global_exists("pizzakin2") && instance_exists(global.pizzakin2))
            followid = global.pizzakin2;
        else if (variable_global_exists("pizzakin1") && instance_exists(global.pizzakin1))
            followid = global.pizzakin1;
        else
            followid = playerid;
        
        break;
    
    case 7:
        if (variable_global_exists("pizzakin7") && instance_exists(global.pizzakin6))
            followid = global.pizzakin7;
        else if (variable_global_exists("pizzakin5") && instance_exists(global.pizzakin5))
            followid = global.pizzakin5;
        else if (variable_global_exists("pizzakin4") && instance_exists(global.pizzakin4))
            followid = global.pizzakin4;
        else if (variable_global_exists("pizzakin3") && instance_exists(global.pizzakin3))
            followid = global.pizzakin3;
        else if (variable_global_exists("pizzakin2") && instance_exists(global.pizzakin2))
            followid = global.pizzakin2;
        else if (variable_global_exists("pizzakin1") && instance_exists(global.pizzakin1))
            followid = global.pizzakin1;
        else
            followid = playerid;
        
        break;
}
