package com.avenida_cabildo.avenida_cabildo;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.MenuItem;
import android.view.View;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;
import com.avenida_cabildo.avenida_cabildo.adapters.LocalViewHolder;
import com.avenida_cabildo.avenida_cabildo.models.Local;
import com.avenida_cabildo.avenida_cabildo.utils.FirebaseReferences;
import com.skocken.efficientadapter.lib.adapter.EfficientAdapter;
import com.skocken.efficientadapter.lib.adapter.EfficientRecyclerAdapter;

import java.util.ArrayList;

public class ActivityFavoritos extends AppCompatActivity {

    private RecyclerView recyclerView;
    private EfficientRecyclerAdapter<Local> adapter;
    private ArrayList<Local> locales;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(com.avenida_cabildo.avenida_cabildo.R.layout.a_favoritos);

        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setTitle("Favoritos");

        recyclerView = (RecyclerView) findViewById(com.avenida_cabildo.avenida_cabildo.R.id.rv);

        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        if(ActivityMain.favoritos != null && ActivityMain.favoritos.size() > 0){

            locales = new ArrayList<>();

            for(int i = 0; i < ActivityMain.favoritos.size(); i++){
                ActivityMain.db.getReference(FirebaseReferences.REF_LOCALES + "/" + ActivityMain.favoritos.get(i)).addListenerForSingleValueEvent(new ValueEventListener() {
                    @Override
                    public void onDataChange(DataSnapshot dataSnapshot) {

                        Local local = Local.snapshotToLocal(dataSnapshot);

                        locales.add(local);

                        if(locales.size() == ActivityMain.favoritos.size()){

                            adapter = new EfficientRecyclerAdapter<Local>(com.avenida_cabildo.avenida_cabildo.R.layout.row_local_visibilidad_baja, LocalViewHolder.class, locales){

                                @Override
                                public int getItemViewType(int position) {
                                    return (int) get(position).getVisibilidad();
                                }

                                @Override
                                public int getLayoutResId(int viewType) {

                                    switch (viewType){

                                        case Local.VISIBILIDAD_ALTA:
                                            return com.avenida_cabildo.avenida_cabildo.R.layout.row_local_visibilidad_alta;

                                        case Local.VISIBILIDAD_MEDIA:
                                            return com.avenida_cabildo.avenida_cabildo.R.layout.row_local_visibilidad_media;

                                        case Local.VISIBILIDAD_BAJA:
                                            return com.avenida_cabildo.avenida_cabildo.R.layout.row_local_visibilidad_baja;

                                    }

                                    return super.getLayoutResId(viewType);
                                }
                            };

                            adapter.setOnItemClickListener(new EfficientAdapter.OnItemClickListener<Local>() {

                                @Override
                                public void onItemClick(EfficientAdapter<Local> adapter, View view, Local object, int position) {
                                    Intent intent = new Intent(ActivityFavoritos.this, ActivityLocalDetalle.class);
                                    intent.putExtra(ActivityLocalDetalle.KEY_LOCAL, object);
                                    startActivity(intent);
                                }

                            });

                            recyclerView.setAdapter(adapter);

                        }
                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {

                    }
                });
            }

            findViewById(com.avenida_cabildo.avenida_cabildo.R.id.tv_sin_items).setVisibility(View.GONE);

        }else{

            findViewById(com.avenida_cabildo.avenida_cabildo.R.id.tv_sin_items).setVisibility(View.VISIBLE);

        }
    }


    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home)
            finish();

        return super.onOptionsItemSelected(item);
    }
}
