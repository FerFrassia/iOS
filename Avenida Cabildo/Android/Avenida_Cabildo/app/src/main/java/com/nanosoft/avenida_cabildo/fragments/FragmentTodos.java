package com.nanosoft.avenida_cabildo.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.ValueEventListener;
import com.nanosoft.avenida_cabildo.ActivityFiltro;
import com.nanosoft.avenida_cabildo.ActivityMain;
import com.nanosoft.avenida_cabildo.R;
import com.nanosoft.avenida_cabildo.ActivityLocalDetalle;
import com.nanosoft.avenida_cabildo.adapters.LocalViewHolder;
import com.nanosoft.avenida_cabildo.models.Local;
import com.nanosoft.avenida_cabildo.utils.FirebaseReferences;
import com.skocken.efficientadapter.lib.adapter.EfficientAdapter;
import com.skocken.efficientadapter.lib.adapter.EfficientRecyclerAdapter;

import java.util.ArrayList;

/**
 * Created by Alan on 11/01/2017.
 */
public class FragmentTodos extends Fragment{

    private static final int CODE_FILTRAR = 592;
    private RecyclerView recyclerView;
    private EfficientRecyclerAdapter<Local> adapter;
    private ArrayList<Local> locales = new ArrayList<>();

    private TextView tvSinItems;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.f_todos, null, false);
        recyclerView = (RecyclerView)  v.findViewById(R.id.rv);
        tvSinItems = (TextView) v.findViewById(R.id.tv_sin_items);
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        setHasOptionsMenu(true);
        actualizarLista();
        return v;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        inflater.inflate(R.menu.todos_filter, menu);
        super.onCreateOptionsMenu(menu, inflater);
    }

    private void actualizarLista(){

        DatabaseReference ref = ActivityMain.db.getReference(FirebaseReferences.REF_LOCALES);
        ref.orderByChild("visibilidad"). addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                locales.clear();

                for (DataSnapshot snapshot: dataSnapshot.getChildren()) {

                    Local local = Local.snapshotToLocal(snapshot);

                    //Verificar filtros ACA, antes de agregar
                    boolean abiertoAhora = ActivityMain.soloAbierto && local.isAbierto();
                    if(ActivityMain.soloAbierto == false) abiertoAhora  = true;

                    boolean visibleEnFiltro = local.visibleEnFiltro();

                    if(abiertoAhora && visibleEnFiltro)
                        locales.add(local);

                }

                adapter = new EfficientRecyclerAdapter<Local>(R.layout.row_local_visibilidad_baja, LocalViewHolder.class, locales){

                    @Override
                    public int getItemViewType(int position) {
                        return (int) get(position).getVisibilidad();
                    }

                    @Override
                    public int getLayoutResId(int viewType) {
                        switch (viewType){
                            case Local.VISIBILIDAD_ALTA:
                                return R.layout.row_local_visibilidad_alta;

                            case Local.VISIBILIDAD_MEDIA:
                                return R.layout.row_local_visibilidad_media;

                            case Local.VISIBILIDAD_BAJA:
                                return R.layout.row_local_visibilidad_baja;
                        }
                        return super.getLayoutResId(viewType);
                    }
                };

                adapter.setOnItemClickListener(new EfficientAdapter.OnItemClickListener<Local>() {

                    @Override
                    public void onItemClick(EfficientAdapter<Local> adapter, View view, Local object, int position) {
                        Intent intent = new Intent(getActivity(), ActivityLocalDetalle.class);
                        intent.putExtra(ActivityLocalDetalle.KEY_LOCAL, object);
                        startActivity(intent);
                    }

                });

                recyclerView.setAdapter(adapter);

                if(locales.size()> 0)
                    tvSinItems.setVisibility(View.GONE);
                else
                    tvSinItems.setVisibility(View.VISIBLE);


            }

            @Override
            public void onCancelled(DatabaseError databaseError) {}
        });

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        switch (item.getItemId()){

            case R.id.action_filtrar:

                Intent intent = new Intent(getActivity(), ActivityFiltro.class);
                startActivityForResult(intent, CODE_FILTRAR);
                break;

        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {

        if(requestCode == CODE_FILTRAR){
            actualizarLista();
        }

        super.onActivityResult(requestCode, resultCode, data);
    }



}
