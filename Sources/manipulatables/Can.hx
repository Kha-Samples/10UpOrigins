package manipulatables;

import kha.Image;
import kha.graphics2.Graphics;
import kha2d.Scene;

class Can extends UseableSprite
{
	private static inline var livetimeInFrames: Int = 120;
	private var livetimeInFramesRemaining: Int = 0;

	public function new(name: String, image: Image, px: Float, py: Float)
	{
		super(name, image, px, py);
		livetimeInFramesRemaining = livetimeInFrames;
		Scene.the.addOther(this);
	}
	
	public override function update(): Void
	{
		--y;
		super.update();
		if (--livetimeInFramesRemaining <= 0)
		{
			Scene.the.removeOther(this);
		}
	}
	
	public override function render(g: Graphics): Void
	{
		g.pushOpacity(Math.min(1, 2 * livetimeInFramesRemaining / livetimeInFrames));
		super.render(g);
		g.popOpacity();
	}
}
