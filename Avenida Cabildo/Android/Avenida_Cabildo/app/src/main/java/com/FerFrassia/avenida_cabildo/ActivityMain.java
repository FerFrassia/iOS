package com.FerFrassia.avenida_cabildo;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.TabLayout;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.FerFrassia.avenida_cabildo.adapters.ViewPagerAdapter;
import com.FerFrassia.avenida_cabildo.fragments.FragmentPromociones;
import com.FerFrassia.avenida_cabildo.fragments.FragmentTodos;
import com.FerFrassia.avenida_cabildo.models.Categoria;
import com.FerFrassia.avenida_cabildo.models.Descuento;
import com.FerFrassia.avenida_cabildo.models.Local;
import com.FerFrassia.avenida_cabildo.utils.FirebaseReferences;

import java.util.ArrayList;

public class ActivityMain extends AppCompatActivity implements View.OnClickListener{

    public static FirebaseUser user;

    public static ArrayList<String> favoritos = new ArrayList<>();
    public static ArrayList<Categoria> categorias = new ArrayList<>();
    public static ArrayList<Descuento> descuentos = new ArrayList<>();
    public static boolean soloAbierto = false;

    public static FirebaseDatabase db;

    private ViewPager pager;
    private ViewPagerAdapter adapter;

    Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(com.FerFrassia.avenida_cabildo.R.layout.a_main);

        toolbar = (Toolbar) findViewById(com.FerFrassia.avenida_cabildo.R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = (DrawerLayout) findViewById(com.FerFrassia.avenida_cabildo.R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, com.FerFrassia.avenida_cabildo.R.string.navigation_drawer_open, com.FerFrassia.avenida_cabildo.R.string.navigation_drawer_close);
        drawer.setDrawerListener(toggle);
        toggle.syncState();

        getSupportActionBar().setTitle("");

        if(db == null)
            db = FirebaseDatabase.getInstance();

        //db.setPersistenceEnabled(true);

        user = FirebaseAuth.getInstance().getCurrentUser();

        obtenerCategorias();
        obtenerFavoritos();

        inicializarNavigationDrawer();

        //Utils.obtenerHashFacebook(this);

    }

    private void inicializarNavigationDrawer(){


        if(user != null){

            Glide.with(this).load(user.getPhotoUrl()).into((ImageView)findViewById(com.FerFrassia.avenida_cabildo.R.id.iv_foto_usuario));
            ((TextView) findViewById(com.FerFrassia.avenida_cabildo.R.id.tv_nombre_usuario)).setText(user.getDisplayName());
            ((TextView) findViewById(com.FerFrassia.avenida_cabildo.R.id.tv_mail_usuario)).setText(user.getEmail());

            findViewById(com.FerFrassia.avenida_cabildo.R.id.ll_iniciar_sesion).setVisibility(View.GONE);

        }else{

            findViewById(com.FerFrassia.avenida_cabildo.R.id.iv_foto_usuario).setVisibility(View.GONE);
            findViewById(com.FerFrassia.avenida_cabildo.R.id.tv_nombre_usuario).setVisibility(View.GONE);
            findViewById(com.FerFrassia.avenida_cabildo.R.id.tv_mail_usuario).setVisibility(View.GONE);

            findViewById(com.FerFrassia.avenida_cabildo.R.id.tv_nav_favoritos).setVisibility(View.GONE);
            findViewById(com.FerFrassia.avenida_cabildo.R.id.ll_cerrar_sesion).setVisibility(View.GONE);

        }

    }

    private void obtenerDescuentos(){
        DatabaseReference ref = db.getReference(FirebaseReferences.REF_DESCUENTOS);

        ref.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {

                descuentos.clear();

                for (DataSnapshot snapshot : dataSnapshot.getChildren()) {

                    String nombre = snapshot.getKey();
                    String imagen = snapshot.child("imagen").child("3x").getValue(String.class);

                    Descuento descuento = new Descuento(nombre, imagen);
                    descuento.setFavorito(true);
                    descuentos.add(descuento);
                }

                iniciarFragmentos();
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    private void obtenerCategorias(){

        DatabaseReference ref = db.getReference(FirebaseReferences.REF_CATEGORIAS);

        ref.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {

                categorias.clear();

                Categoria categoriaTodos = null;

                for (DataSnapshot snapshot : dataSnapshot.getChildren()) {

                    String nombre = snapshot.getKey();
                    String imagen = snapshot.child("imagen").child("3x").getValue(String.class);

                    Categoria categoria = new Categoria(nombre, imagen);
                    categoria.setFavorita(true);

                    if(!categoria.getNombre().equals("Todos"))
                        categorias.add(categoria);
                    else
                        categoriaTodos = categoria;
                }

                if(categoriaTodos != null)
                    categorias.add(0,categoriaTodos);

                obtenerDescuentos();

            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });

    }

    private  void obtenerFavoritos(){

        if(user != null){
            DatabaseReference ref = db.getReference(FirebaseReferences.REF_USUARIOS + "/" + user.getUid());

            ref.addListenerForSingleValueEvent(new ValueEventListener() {
                @Override
                public void onDataChange(DataSnapshot dataSnapshot) {

                    favoritos = new ArrayList<String>();

                    for (DataSnapshot ss: dataSnapshot.getChildren()) {
                        favoritos.add(ss.getValue(String.class));
                    }

                }

                @Override
                public void onCancelled(DatabaseError databaseError) {

                }
            });
        }
    }

    private void iniciarFragmentos(){

        //Agrego los dos fragmentos principales.
        pager = (ViewPager) findViewById(com.FerFrassia.avenida_cabildo.R.id.vp_principal);
        adapter = new ViewPagerAdapter(getSupportFragmentManager());

        adapter.agregarFragmento(new FragmentPromociones(), "Promociones");
        adapter.agregarFragmento(new FragmentTodos(), "Todos");
        pager.setAdapter(adapter);

        //Pongo a funcionar el tablayout
        TabLayout tabLayout = (TabLayout) findViewById(com.FerFrassia.avenida_cabildo.R.id.tab_layout);
        tabLayout.setupWithViewPager(pager);
    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(com.FerFrassia.avenida_cabildo.R.id.drawer_layout);
        if(drawer.isDrawerOpen(GravityCompat.START)){
            drawer.closeDrawer(GravityCompat.START);
        }else{
            super.onBackPressed();
        }
    }

    @Override
    public void onClick(View view) {

    }

    public void iniciarSesion(View v){
        Intent intent = new Intent(this, ActivityLogin.class);
        startActivity(intent);
        finish();
    }

    public void cerrarSesion(View v){

        if(user != null)
            FirebaseAuth.getInstance().signOut();

        Intent intent = new Intent(this, ActivityLogin.class);
        startActivity(intent);
        finish();

    }

    public void verFavoritos(View v){
        Intent intent = new Intent(this,ActivityFavoritos.class);
        startActivity(intent);
    }


    public static boolean esFavorito(Local local){

        for(int i = 0; i < favoritos.size(); i++){
            if(local.getNombre().equals(favoritos.get(i)))
                return true;
        }

        return false;
    }


}
