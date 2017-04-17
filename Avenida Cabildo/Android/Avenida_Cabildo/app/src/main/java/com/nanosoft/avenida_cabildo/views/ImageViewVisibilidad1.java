package com.nanosoft.avenida_cabildo.views;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.ImageView;

/**
 * Created by Alan on 18/01/2017.
 */

public class ImageViewVisibilidad1 extends ImageView {



    public ImageViewVisibilidad1(Context context) {
        super(context);
    }

    public ImageViewVisibilidad1(Context context, AttributeSet attrs) {
        super(context, attrs);
    }


    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);

        int width = getMeasuredWidth();
        int height = (int) (width * 0.7);

        setMeasuredDimension(width, height);
    }

}
