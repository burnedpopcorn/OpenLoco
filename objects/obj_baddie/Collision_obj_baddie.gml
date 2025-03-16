if (object_index == other.object_index && image_xscale == other.image_xscale && hsp != 0 && other.hsp != 0 && id < other.id && state != baddiestates.grabbed && state != baddiestates.stun && state != baddiestates.turn && other.state != baddiestates.stun && other.state != baddiestates.grabbed)
    hsp = -other.image_xscale;
