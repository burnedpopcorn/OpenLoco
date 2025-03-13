switch (state)
{
    case 0:
        mask_index = spr_hungrypillar;
        break;
    
    case 1:
        scr_hungrypillar_hit();
        mask_index = spr_null;
        break;
}
