switch (state)
{
    case pillar.idle:
        mask_index = spr_hungrypillar;
        break;
    
    case pillar.hit:
        scr_hungrypillar_hit();
        mask_index = spr_null;
        break;
}
