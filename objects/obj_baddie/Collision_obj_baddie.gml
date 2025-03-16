if (object_index == other.object_index && image_xscale == other.image_xscale && hsp != 0 && other.hsp != 0 && id < other.id && state != states.grabbed && state != baddiestates.stun && state != baddiestates.turn && other.state != states.capefall && other.state != states.grabbed)
    hsp = -other.image_xscale;
