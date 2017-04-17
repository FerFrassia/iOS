package com.nanosoft.avenida_cabildo;

import android.os.Bundle;
import android.support.design.widget.AppBarLayout;
import android.support.design.widget.TabLayout;
import android.support.v4.app.DialogFragment;
import android.support.v4.view.ViewPager;
import android.support.v4.widget.NestedScrollView;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.TypedValue;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.google.firebase.database.DatabaseReference;
import com.nanosoft.avenida_cabildo.adapters.ViewPagerAdapter;
import com.nanosoft.avenida_cabildo.fragments.FragmentDetalleDescuentos;
import com.nanosoft.avenida_cabildo.fragments.FragmentDetalleDetalles;
import com.nanosoft.avenida_cabildo.fragments.FragmentFiltroCategorias;
import com.nanosoft.avenida_cabildo.fragments.FragmentFiltroDescuentos;
import com.nanosoft.avenida_cabildo.fragments.FragmentShare;
import com.nanosoft.avenida_cabildo.models.Local;
import com.nanosoft.avenida_cabildo.utils.FirebaseReferences;
import com.nanosoft.avenida_cabildo.utils.Utils;

public class ActivityLocalDetalle extends AppCompatActivity {

    public static final String KEY_LOCAL = "local";
    private Local mLocal;

    private ImageView ivLogo;

    private enum State {
        EXPANDED,
        COLLAPSED,
        IDLE
    }

    float alto;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.a_locales_detalle);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setTitle("");

        mLocal = (Local) getIntent().getSerializableExtra(KEY_LOCAL);

        Glide.with(this).load(mLocal.getImagen_fondo())
                .into((ImageView) findViewById(R.id.iv_background));

        ivLogo = (ImageView) findViewById(R.id.iv_logo);
        Glide.with(this).load(mLocal.getImagen_logo())
                .into(ivLogo);

        AppBarLayout appBarLayout = (AppBarLayout) findViewById(R.id.app_bar);

        alto = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 90, getResources().getDisplayMetrics());

        appBarLayout.addOnOffsetChangedListener(new AppBarLayout.OnOffsetChangedListener() {

            private State state;

            @Override
            public void onOffsetChanged(AppBarLayout appBarLayout, int verticalOffset) {

                if (verticalOffset == 0) {
                    if (state != State.EXPANDED) {
                        //ivLogo.animate().setStartDelay(300).translationY(0).setDuration(300).start();
                        ivLogo.animate().setStartDelay(300).scaleX(1f).scaleY(1f).setDuration(300).start();
                        state = State.EXPANDED;
                    }
                } else if (Math.abs(verticalOffset) >= appBarLayout.getTotalScrollRange()) {
                    if (state != State.COLLAPSED) {
                        //ivLogo.animate().translationY(alto).setDuration(0).start();
                        ivLogo.animate().scaleX(0f).scaleY(0f).setDuration(300).start();
                        state = State.COLLAPSED;
                    }
                }


            }
        });


        ImageView ivFavorito = (ImageView) findViewById(R.id.iv_favorito);
        if(mLocal.isFavorito()){
            ivFavorito.setImageResource(R.drawable.ic_star_amarilla);
        }else{
            ivFavorito.setImageResource(R.drawable.ic_star);
        }

        ((TextView) findViewById(R.id.tv_nombre)).setText(mLocal.getNombre());
        ((TextView) findViewById(R.id.tv_categoria)).setText(mLocal.getCategoria());

        TextView tvDescuento = (TextView) findViewById(R.id.tv_descuento);

        if(mLocal.getEfectivo() != null && mLocal.getEfectivo().length() > 2){
            tvDescuento.setText(mLocal.getEfectivo() + " OFF");
        }else{
            tvDescuento.setVisibility(View.GONE);
        }

        TabLayout tabLayout = (TabLayout) findViewById(R.id.tabs);
        ViewPager pager = (ViewPager) findViewById(R.id.pager);

        ViewPagerAdapter adapter = new ViewPagerAdapter(getSupportFragmentManager());
        adapter.agregarFragmento(FragmentDetalleDescuentos.newInstance(mLocal.getDescuentoss()), "Descuentos");
        adapter.agregarFragmento(FragmentDetalleDetalles.newInstance(mLocal), "Detalle");

        pager.setAdapter(adapter);
        tabLayout.setupWithViewPager(pager);


    }

    public void compartir(View v){

        /*FragmentShare fragment = FragmentShare.newInstance(mLocal);
        fragment.setHasOptionsMenu(false);
        fragment.show(getSupportFragmentManager(), "");
        */

        if(mLocal.getWeb() != null)
            Utils.compartirLink(this, mLocal.getWeb(), mLocal.getImagen_logo());

    }

    public void marcarFavorito(View v){

        if(ActivityMain.user != null){

            mLocal.setFavorito(!mLocal.isFavorito());

            DatabaseReference ref =
                    ActivityMain.db.getReference(FirebaseReferences.REF_USUARIOS + "/" + ActivityMain.user.getUid());


            ImageView iv = ((ImageView) v);

            if(mLocal.isFavorito()){

                boolean esFavorito = false;

                for(int i = 0; i < ActivityMain.favoritos.size(); i++){
                    if(ActivityMain.favoritos.get(i).equals(mLocal.getNombre())) {
                        esFavorito = true;
                    }
                }

                if(!esFavorito)
                    ActivityMain.favoritos.add(mLocal.getNombre());

                iv.setImageResource(R.drawable.ic_star_amarilla);
            }else{
                iv.setImageResource(R.drawable.ic_star);

                for(int i = 0; i < ActivityMain.favoritos.size(); i++){
                    if(ActivityMain.favoritos.get(i).equals(mLocal.getNombre())) {
                        ActivityMain.favoritos.remove(i);
                    }
                }
            }

            ref.setValue(ActivityMain.favoritos);

        }else{
            Toast.makeText(this, "Inicia sesion para agregar favoritos", Toast.LENGTH_LONG).show();
        }

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if(item.getItemId() == android.R.id.home)
            finish();

        return super.onOptionsItemSelected(item);
    }

}
