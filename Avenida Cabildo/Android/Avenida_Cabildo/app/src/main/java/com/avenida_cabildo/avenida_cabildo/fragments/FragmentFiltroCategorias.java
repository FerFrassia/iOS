package com.avenida_cabildo.avenida_cabildo.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.avenida_cabildo.avenida_cabildo.ActivityMain;
import com.avenida_cabildo.avenida_cabildo.adapters.CategoriasFiltrosViewHolder;
import com.avenida_cabildo.avenida_cabildo.models.Categoria;
import com.skocken.efficientadapter.lib.adapter.EfficientAdapter;
import com.skocken.efficientadapter.lib.adapter.EfficientRecyclerAdapter;
import com.avenida_cabildo.avenida_cabildo.R;

/**
 * Created by Alan on 22/01/2017.
 */

public class FragmentFiltroCategorias extends Fragment {

    EfficientRecyclerAdapter<Categoria> adapter;
    int todosPosition = 0;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        RecyclerView rv = new RecyclerView(getActivity());

        float scale = getResources().getDisplayMetrics().density;
        int dpAsPixels = (int) (16*scale + 0.5f);
        rv.setPadding(dpAsPixels,0,dpAsPixels,0);

        rv.setLayoutManager(new LinearLayoutManager(getActivity()));


        for(int i = 0; i < ActivityMain.categorias.size(); i++){
            if(ActivityMain.categorias.get(i).getNombre().equals("Todos")){
                todosPosition = i;
                break;
            }
        }

        adapter = new EfficientRecyclerAdapter<Categoria>(R.layout.row_filtro_categoria, CategoriasFiltrosViewHolder.class, ActivityMain.categorias);
        adapter.setOnItemClickListener(new EfficientAdapter.OnItemClickListener<Categoria>() {
            @Override
            public void onItemClick(EfficientAdapter<Categoria> adapter, View view, Categoria object, int position) {

                adapter.get(position).setFavorita(!object.isFavorita());

                if(position == todosPosition) {

                    for(int i = 0; i < adapter.size(); i++){
                        adapter.get(i).setFavorita(adapter.get(position).isFavorita());
                        adapter.notifyItemChanged(i);
                    }

                }else{

                    //Se puso el valor en true?

                    boolean todosSeleccionados = true;

                    for(int i = 0; i < adapter.size(); i++){
                        if(i != todosPosition && adapter.get(i).isFavorita() == false ){
                            todosSeleccionados = false;
                            break;
                        }
                    }

                    if(todosSeleccionados){
                        adapter.get(todosPosition).setFavorita(true);
                    }else{
                        adapter.get(todosPosition).setFavorita(false);
                    }

                    adapter.notifyItemChanged(todosPosition);
                    adapter.notifyItemChanged(position);
                }
            }
        });

        rv.setAdapter(adapter);
        return rv;
    }


    public void resetear() {

        if(adapter != null){
            for(int i = 0; i < adapter.size(); i++){
                adapter.get(i).setFavorita(true);
            }

            adapter.notifyDataSetChanged();
        }

    }
}
