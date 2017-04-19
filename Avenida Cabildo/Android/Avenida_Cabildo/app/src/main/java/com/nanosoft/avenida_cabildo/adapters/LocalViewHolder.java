package com.nanosoft.avenida_cabildo.adapters;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.v4.app.FragmentManager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.google.firebase.database.DatabaseReference;
import com.haozhang.lib.SlantedTextView;
import com.nanosoft.avenida_cabildo.ActivityLocalDetalle;
import com.nanosoft.avenida_cabildo.ActivityMain;
import com.nanosoft.avenida_cabildo.R;
import com.nanosoft.avenida_cabildo.fragments.FragmentShare;
import com.nanosoft.avenida_cabildo.models.Descuento;
import com.nanosoft.avenida_cabildo.models.Local;
import com.nanosoft.avenida_cabildo.utils.FirebaseReferences;
import com.nanosoft.avenida_cabildo.utils.Utils;
import com.skocken.efficientadapter.lib.adapter.EfficientAdapter;
import com.skocken.efficientadapter.lib.adapter.EfficientRecyclerAdapter;
import com.skocken.efficientadapter.lib.viewholder.EfficientViewHolder;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Alan on 18/01/2017.
 */

public class LocalViewHolder extends EfficientViewHolder<Local> implements View.OnClickListener{

    private LinearLayoutManager layoutManager;
    private int mPosition = -1;

    public LocalViewHolder(View itemView) {
        super(itemView);
        layoutManager = new LinearLayoutManager(getContext(), LinearLayoutManager.HORIZONTAL, false);
    }

    @Override
    protected void updateView(Context context, Local local) {

        TextView nombre = findViewByIdEfficient(R.id.tv_nombre);
        TextView direccion = findViewByIdEfficient(R.id.tv_direccion);
        TextView descripcion = findViewByIdEfficient(R.id.tv_descripcion);
        SlantedTextView slantedTextView = findViewByIdEfficient(R.id.stv_descuento);
        TextView tvDescuento = findViewByIdEfficient(R.id.tv_descuento);

        ImageView iv = findViewByIdEfficient(R.id.iv_fondo);
        ImageView ivLogo = findViewByIdEfficient(R.id.iv_logo);

        RecyclerView rv = findViewByIdEfficient(R.id.rv_descuentos);

        ImageView ivCompartir = findViewByIdEfficient(R.id.iv_compartir);
        ImageView ivFavorito = findViewByIdEfficient(R.id.iv_favorito);

        if(ivCompartir != null) ivCompartir.setOnClickListener(this);
        if(ivFavorito != null) ivFavorito.setOnClickListener(this);

        if(local.isFavorito()){
            ivFavorito.setImageResource(R.drawable.ic_star_amarilla);
        }else{
            ivFavorito.setImageResource(R.drawable.ic_star);
        }

        nombre.setText(local.getNombre());
        direccion.setText(local.getDireccion());
        if(descripcion != null) descripcion.setText(local.getDetalle_texto());
        if(slantedTextView != null) slantedTextView.setText(local.getEfectivo() + " OFF");
        if(tvDescuento != null) tvDescuento.setText(local.getEfectivo() + " OFF");

        if(iv != null) Glide.with(getContext()).load(local.getImagen_fondo()).into(iv);
        if(ivLogo != null) Glide.with(getContext()).load(local.getImagen_logo()).into(ivLogo);

        if(rv != null && local.getDescuentoss() != null && local.getDescuentoss().size() > 0){
            rv.setLayoutManager(layoutManager);
            rv.setAdapter(new EfficientRecyclerAdapter<Descuento>(R.layout.row_descuento, DescuentoViewHolder.class, local.getDescuentoss()));
        }else if (rv != null ) {
            rv.setVisibility(View.GONE);
        }

        TextView tvVerMas = findViewByIdEfficient(R.id.tv_ver_mas);
        if(tvVerMas != null) tvVerMas.setOnClickListener(this);
    }

    @Override
    public boolean isClickable() {
        return true;
    }

    @Override
    public void onClick(View view) {

        int position = getLastBindPosition();

        if(position != -1){
            switch (view.getId()){

                case R.id.tv_ver_mas:

                    Intent intent = new Intent(getContext(), ActivityLocalDetalle.class);
                    intent.putExtra(ActivityLocalDetalle.KEY_LOCAL, getAdapter().get(position));
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    getContext().getApplicationContext().startActivity(intent);

                    break;

                case R.id.iv_compartir:

                    /*FragmentManager manager = ((AppCompatActivity)getContext()).getSupportFragmentManager();
                    FragmentShare fragment = FragmentShare.newInstance(getAdapter().get(position));
                    fragment.setHasOptionsMenu(false);
                    fragment.show(manager, "");
                    */

                    Utils.compartirLink(getContext(), getAdapter().get(position).getWeb(), getAdapter().get(position).getNombre(), getAdapter().get(position).getImagen_logo());

                    break;

                case R.id.iv_favorito:

                    if(ActivityMain.user != null){

                        getAdapter().get(position).setFavorito(!getAdapter().get(position).isFavorito());

                        DatabaseReference ref =
                                ActivityMain.db.getReference(FirebaseReferences.REF_USUARIOS + "/" + ActivityMain.user.getUid());


                        ImageView iv = ((ImageView) view);

                        if(getAdapter().get(position).isFavorito()){

                            boolean esFavorito = false;

                            for(int i = 0; i < ActivityMain.favoritos.size(); i++){
                                if(ActivityMain.favoritos.get(i).equals(getAdapter().get(position).getNombre())) {
                                    esFavorito = true;
                                }
                            }

                            if(!esFavorito)
                                ActivityMain.favoritos.add(getAdapter().get(position).getNombre());

                            iv.setImageResource(R.drawable.ic_star_amarilla);
                        }else{
                            iv.setImageResource(R.drawable.ic_star);

                            for(int i = 0; i < ActivityMain.favoritos.size(); i++){
                                if(ActivityMain.favoritos.get(i).equals(getAdapter().get(position).getNombre())) {
                                    ActivityMain.favoritos.remove(i);
                                }
                            }

                        }

                        ref.setValue(ActivityMain.favoritos);

                    }else{
                        Toast.makeText(getContext(), "Inicia sesion para agregar favoritos", Toast.LENGTH_LONG).show();
                    }




                    break;

            }
        }


    }
}
