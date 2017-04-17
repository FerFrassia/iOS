package com.nanosoft.avenida_cabildo;

import android.app.Activity;
import android.content.Intent;
import android.support.design.widget.TabLayout;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;
import com.nanosoft.avenida_cabildo.adapters.LocalesAutoCompleteAdapter;
import com.nanosoft.avenida_cabildo.adapters.ViewPagerAdapter;
import com.nanosoft.avenida_cabildo.fragments.FragmentFiltroCategorias;
import com.nanosoft.avenida_cabildo.fragments.FragmentFiltroDescuentos;
import com.nanosoft.avenida_cabildo.models.Local;
import com.nanosoft.avenida_cabildo.utils.FirebaseReferences;
import com.sevenheaven.iosswitch.ShSwitchView;

import java.util.ArrayList;

public class ActivityFiltro extends AppCompatActivity {

    private ViewPager vp;
    private ViewPagerAdapter adapter;

    private FragmentFiltroCategorias fCategorias;
    private FragmentFiltroDescuentos fDescuentos;

    //private ArrayList<Local> locales;
    //private LocalesAutoCompleteAdapter autocompleteAdapter;

    private ArrayAdapter<Local> adapterLocales;
    private AutoCompleteTextView autoCompleteTextView;

    private ShSwitchView soloAbiertos;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.a_filtro);

        getSupportActionBar().setTitle("Filtrar");
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        setResult(RESULT_OK);

        vp = (ViewPager) findViewById(R.id.vp);
        adapter = new ViewPagerAdapter(getSupportFragmentManager());


        //autocompleteAdapter = new LocalesAutoCompleteAdapter(this);


        autoCompleteTextView = (AutoCompleteTextView) findViewById(R.id.et_buscar);

        adapterLocales = new ArrayAdapter<Local>(ActivityFiltro.this, android.R.layout.simple_dropdown_item_1line);

        autoCompleteTextView.setAdapter(adapterLocales);

        autoCompleteTextView.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

                //Actualizar Info.
                ActivityMain.db.getReference(FirebaseReferences.REF_LOCALES)

                        .orderByChild("nombre_simple")
                        .startAt(charSequence.toString())
                        .limitToFirst(10)
                        .addListenerForSingleValueEvent(new ValueEventListener() {

                    @Override
                    public void onDataChange(DataSnapshot dataSnapshot) {
                        adapterLocales.clear();
                        for (DataSnapshot snapShot: dataSnapshot.getChildren()) {
                            Local local = Local.snapshotToLocal(snapShot);
                            adapterLocales.add(local);
                        }
                        adapterLocales.notifyDataSetChanged();
                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {

                    }
                });


            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });


        autoCompleteTextView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent intent = new Intent(ActivityFiltro.this, ActivityLocalDetalle.class);
                intent.putExtra(ActivityLocalDetalle.KEY_LOCAL, adapterLocales.getItem(i));
                startActivity(intent);

                autoCompleteTextView.setText("");
            }
        });

        fCategorias = new FragmentFiltroCategorias();
        fDescuentos = new FragmentFiltroDescuentos();

        adapter.agregarFragmento(fCategorias, "Categorias");
        adapter.agregarFragmento(fDescuentos, "Descuentos");

        vp.setAdapter(adapter);

        TabLayout tabLayout = (TabLayout) findViewById(R.id.tabs);
        tabLayout.setupWithViewPager(vp);

        soloAbiertos = (ShSwitchView) findViewById(R.id.switch_solo_abiertos);
        soloAbiertos.setOn(ActivityMain.soloAbierto);
        soloAbiertos.setOnSwitchStateChangeListener(new ShSwitchView.OnSwitchStateChangeListener() {
            @Override
            public void onSwitchStateChange(boolean isOn) {
                ActivityMain.soloAbierto = isOn;
            }
        });
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if(item.getItemId() == android.R.id.home)
            finish();
        else if (item.getItemId() == R.id.action_limpiar){

            if(fCategorias != null){
                fCategorias.resetear();
            }

            if(fDescuentos != null){
                fDescuentos.resetear();
            }

            soloAbiertos.setOn(false);
            ActivityMain.soloAbierto = false;

        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.filtro, menu);
        return true;
    }
}
