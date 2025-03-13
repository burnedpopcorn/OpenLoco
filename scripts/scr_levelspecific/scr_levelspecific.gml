function get_level_rank()
{
    switch (global.leveltosave)
    {
        case "hall":
            return 30000;
        
        case "locotown":
            return 30000;
        
        default:
            return 15000;
    }
}
